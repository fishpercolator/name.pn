class Views::MailingList::Show < Views::Base
  include Phlex::Rails::Helpers::TurboFrameTag

  def view_template
    turbo_frame_tag([current_user, 'mailing_list']) do
      SectionHeading(class: 'mb-4') { t('.title') }
      Card do |card|
        card.body do
          if current_user.subscribed_to_mailing_list?
            p { t('.currently_subscribed_html') }
            toggle(users_mailing_list_unsubscribe_path, :danger) { t('.unsubscribe') }
          else
            p { t('.currently_unsubscribed_html') }
            toggle(users_mailing_list_subscribe_path, :success) { t('.subscribe') }
          end
        end
      end
    end
  end

  private

  def toggle(path, variant, &)
    div(class: 'mt-4') do
      Button(href: path, method: :post, variant:, &)
    end
  end
end
