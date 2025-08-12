# frozen_string_literal: true

class Components::Home::Card::Url < Components::Base
  def view_template
    render Home::Card.new(title: t('.title'), edit: profile_path(:slug), class: 'md:col-span-2 bg-indigo-50 dark:bg-indigo-950', data: {controller: 'url', url_copied_class: 'is-copied'}) do |hc|
      hc.content do
        div(class: 'flex flex-col items-center') do
          p(class: 'text-2xl font-semibold wrap-anywhere', data: {url_target: 'url'}) { user_url(current_user, only_path: false) }
          if current_user.pronoun_sets.present?
            p(class: 'text-muted-foreground font-italic mt-6') { t('.or_with_pronouns') }
            current_user.pronoun_sets.each do |ps|
              p(class: 'text-muted-foreground wrap-anywhere') { user_url(current_user, only_path: false, nominative: ps.nominative, oblique: ps.oblique) }
            end
          end
        end
      end
      hc.footer do
        edit_button(hc)
        view_button(hc)
        copy_button(hc)
      end
    end
  end

  private

  def edit_button(hc)
    hc.footer_button(href: profile_path(:slug)) do
      icon 'pencil', class: 'w-5 h-5 fill-current mr-1'
      span { t('actions.edit') }
    end
  end

  def view_button(hc)
    if current_user.profile_complete?
      hc.footer_button(href: user_url(current_user), target: '_blank') do
        icon 'open-in-new', class: 'w-5 h-5 fill-current mr-1'
        span { t('.view_your_page') }
      end
    else
      div(title: t('.you_must_complete'), class: 'grow basis-0') do
        hc.footer_button(RubyUI::Button, disabled: true, class: 'w-full') do
          icon 'open-in-new', class: 'w-5 h-5 fill-current mr-1'
          span { t('.view_your_page') }
        end
      end
    end
  end

  def copy_button(hc)
    if current_user.profile_complete?
      hc.footer_button(RubyUI::Button, class: 'group', data: {url_target: 'copyButton', action: 'url#copy'}) do
        icon 'clipboard-outline', class: 'group-[.is-copied]:hidden w-5 h-5 fill-current mr-1'
        span(class: 'group-[.is-copied]:hidden') { t('.copy_to_clipboard') }
        icon 'clipboard-check-outline', class: 'hidden group-[.is-copied]:inline w-5 h-5 fill-current mr-1'
        span(class: 'hidden group-[.is-copied]:inline') { t('.copied') }
      end
    else
      div(title: t('.you_must_complete'), class: 'grow basis-0') do
        hc.footer_button(RubyUI::Button, disabled: true, class: 'w-full') do
          icon 'clipboard-outline', class: 'w-5 h-5 fill-current mr-1'
          span { t('.copy_to_clipboard') }
        end
      end
    end
  end
end
