module MailingListable
  extend ActiveSupport::Concern

  def self.buttondown
    ENV["BUTTONDOWN_API_KEY"].presence&.then { Buttondown.new(it) }
  end

  included do
    # Set this attribute during user creation to subscribe them to mailing list
    attr_accessor :subscribe_to_mailing_list
    after_create :subscribe_to_mailing_list!, if: :subscribe_to_mailing_list
    after_update :subscribe_to_mailing_list!, if: :mailing_list_data_changed?
    after_destroy_commit :unsubscribe_from_mailing_list!

    def subscribed_to_mailing_list?
      mailing_list { it.subscribed?(email_was || email) }
    end

    def subscribe_to_mailing_list!
      mailing_list { it.subscribe!(email, mailing_list_data) }
    end

    def unsubscribe_from_mailing_list!
      mailing_list { it.unsubscribe!(email) }
    end

    # Get the user's email at the last save if it is not the current email
    def email_was
      saved_change_to_email? && email_before_last_save.present? && email_before_last_save
    end

    private

    def mailing_list
      MailingListable.buttondown&.then { yield it }
    rescue Faraday::Error => error
      report_mailing_list_failure(error)
      nil
    end

    def report_mailing_list_failure(error)
      AdminMailer.with(email:, error: failure_details(error)).buttondown_failed.deliver_later
    end

    def failure_details(error) = [ error.message, error.response_body ].compact.join("\n")

    def mailing_list_data
      slice(:full_name, :formal_name, :email_name, :email_was).reject { |_, v| v.blank? }
    end

    def mailing_list_data_changed?
      saved_change_to_mailing_list_data? && subscribed_to_mailing_list?
    end

    def saved_change_to_mailing_list_data?
      %w[email full_name formal_name email_name].any? { saved_change_to_attribute?(it) }
    end
  end
end
