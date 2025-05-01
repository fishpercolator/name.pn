# frozen_string_literal: true
class StatPanel < Arbre::Component
  builder_method :stat_panel

  def build(title, stat, link=nil)
    panel title do
      div(class: 'text-center text-6xl') do
        link.present? ? link_to(stat, link, class: 'no-underline') : stat
      end
    end
  end
end

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div(class: 'grid grid-cols-1 sm:grid-cols-2 gap-4') do
      stat_panel "Total registered users", User.count, admin_users_path
      stat_panel "Users who have completed profile", User.profile_complete.count, admin_users_path(scope: 'profile_complete')
      stat_panel "Users who have uploaded audio", User.where.associated(:pronunciation_attachment).count, admin_users_path(scope: 'has_audio')
      stat_panel "Sign-up rate (per week; over last 4 weeks", User.created_since(4.weeks.ago).count / 4
    end
  end
end
