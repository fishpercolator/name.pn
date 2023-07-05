module MailingListable
  extend ActiveSupport::Concern

  def self.buttondown
    if Figaro.env.BUTTONDOWN_API_KEY?
      @buttondown = Buttondown.new(Figaro.env.BUTTONDOWN_API_KEY)
    else
      nil
    end
  end
  
  included do
    # Set this attribute during user creation to subscribe them to mailing list
    attr_accessor :subscribe_to_mailing_list
    after_create :subscribe_to_mailing_list!, if: :subscribe_to_mailing_list
    after_update :subscribe_to_mailing_list!, if: :mailing_list_data_changed?
    
    def subscribed_to_mailing_list?
      MailingListable.buttondown&.subscribed?(email)
    end
    
    def subscribe_to_mailing_list!
      MailingListable.buttondown&.subscribe!(email, mailing_list_data)
    end
    
    def unsubscribe_from_mailing_list!
      MailingListable.buttondown&.unsubscribe!(email)
    end
    
    private

    def mailing_list_data
      slice(:full_name, :formal_name).reject {|_,v| v.blank?}
    end
    
    def mailing_list_data_changed?
      subscribed_to_mailing_list? && (saved_change_to_email? || saved_change_to_full_name? || saved_change_to_formal_name?)
    end
    
  end
  
end
