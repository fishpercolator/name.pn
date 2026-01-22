# frozen_string_literal: true

class Components::Home::Card::Links < Components::Base
  def view_template
    render Home::Card.new(title: t('.title'), edit: profile_path(:links), class: 'bg-links') do |hc|
      hc.content do
        hc.blurb { t('profile.links.blurb') }
        if current_user.links.present?
          ul(class: 'list-disc pl-5') do
            current_user.links.order(:title).each do |link|
              li(class: 'mb-2') { Link(class: '-ml-4 py-1 h-auto underline', href: link.url, rel: 'noopener') { link.title } }
            end
          end
        else
          p { hc.not_set }
        end
      end
    end
  end
end
