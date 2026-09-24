class Views::MailingList::Show < Views::Base
  include Phlex::Rails::Helpers::TurboFrameTag

  def view_template
    turbo_frame_tag([current_user, 'mailing_list']) do
      SectionHeading(class: 'mb-4') { t('.title') }
      Card do
        div(class: 'card-body') { current_user.subscribed_to_mailing_list? ? subscribed : unsubscribed }
      end
    end
  end

  private

  def subscribed
    p { t('.currently_subscribed_html') }
    toggle(users_mailing_list_unsubscribe_path, :danger) { t('.unsubscribe') }
  end

  def unsubscribed
    p { t('.currently_unsubscribed_html') }
    toggle(users_mailing_list_subscribe_path, :success) { t('.subscribe') }
  end

  def toggle(path, variant, &)
    div(class: 'mt-4') { Button(href: path, method: :post, variant:, &) }
  end
end
