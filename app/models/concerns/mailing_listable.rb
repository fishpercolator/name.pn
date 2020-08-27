module MailingListable
  extend ActiveSupport::Concern
  
  def self.gibbon
    Figaro.env.MAILCHIMP_API_KEY? && @gibbon ||= Gibbon::Request.new(api_key: Figaro.env.MAILCHIMP_API_KEY, symbolize_keys: true)
  end
  
  def self.mailing_list
    gibbon&.lists(Figaro.env.MAILCHIMP_LIST_ID)
  end
    
  included do
    # Set this attribute during user creation to subscribe them to mailing list
    attr_accessor :subscribe_to_mailing_list
    after_create :subscribe_to_mailing_list!, if: :subscribe_to_mailing_list
    after_update :update_data_in_mailchimp, if: :mailchimp_data_changed?
    
    def subscribed_to_mailing_list?
      mailchimp_member&.retrieve&.body&.dig(:status) == 'subscribed'
    rescue Gibbon::MailChimpError
      false
    end
    
    # Update data in mailchimp. Will create the record if status is provided and none exists
    def update_data_in_mailchimp(status: nil)
      return if MailingListable.gibbon.blank? # do nothing in development
      data = mailchimp_data
      if status.present?
        data[:status] = status
        mailchimp_member&.upsert(body: data)
      else
        mailchimp_member&.update(body: data)
      end
    end
    
    def subscribe_to_mailing_list!
      update_data_in_mailchimp(status: 'subscribed')
    end
    
    def unsubscribe_from_mailing_list!
      update_data_in_mailchimp(status: 'unsubscribed')
    end
    
    private
    
    def mailchimp_member
      MailingListable.mailing_list&.members(Digest::MD5.hexdigest(email))
    end
    
    def mailchimp_data
      {email_address: email, merge_fields: {NAME: full_name || '', FORMAL: formal_name || ''}}
    end
    
    def mailchimp_data_changed?
      subscribed_to_mailing_list? && (saved_change_to_email? || saved_change_to_full_name? || saved_change_to_formal_name?)
    end
    
  end
  
end
