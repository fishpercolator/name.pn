# frozen_string_literal: true

class Components::ShellLayout < Components::Layout
  register_value_helper :user_signed_in?
  register_value_helper :current_user

  def initialize(main_class: 'flex flex-col grow px-2 sm:px-4 sm:container py-4 sm:py-8', flashes_class: '')
    @main_class = main_class
    @flashes_class = flashes_class
  end

  def view_template(&)
    super do
      PageHeader do |header|
        header.main_link(page_path('about')) { t('.about') }
        if user_signed_in?
          header.action_link(admin_root_path) { t('.admin') } if current_user.role_admin?
          header.action_link(edit_user_registration_path) { t('devise.registrations.edit.title') }
          header.action_link(destroy_user_session_path, data: {turbo_method: :delete}) { t('devise.sessions.destroy.title') }
        else
          header.action_link(new_user_session_path) { t('devise.sessions.new.title') }
          header.action_link(new_user_registration_path) { t('devise.registrations.new.title') }
        end
      end
      main(class: @main_class) do
        Flashes(class: @flashes_class)
        yield
      end
      PageFooter do |footer|
        footer.left_link(page_path('terms')) do
          icon 'file-sign', class: 'h-4 w-4 fill-current mr-1'
          span { t('.terms') }
        end
        footer.left_link(page_path('privacy')) do 
          icon 'shield-account', class: 'h-4 w-4 fill-current mr-1'
          span { t('.privacy') }
        end
        footer.right_link('https://github.com/fishpercolator/name.pn') do
          icon 'github', class: 'h-4 w-4 fill-current mr-1'
          span { t('.github') }
        end
        footer.right_link('https://github.com/orgs/fishpercolator/projects/1') do
          icon 'map', class: 'h-4 w-4 fill-current mr-1'
          span { t('.roadmap') }
        end
        footer.right_link(rswag_ui_path) do
          icon 'cogs', class: 'h-4 w-4 fill-current mr-1'
          span { t('.api') }
        end
      end
    end
  end

  def body_class
    'min-h-screen flex flex-col bg-linear-to-b bg-fixed from-zinc-100 to-zinc-200 dark:from-black dark:to-zinc-800 text-foreground'
  end

  def html_class
    'min-h-screen scroll-pt-15'
  end
end
