ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Total registered users" do
          figure class: 'headline-number' do
            link_to User.count, admin_users_path
          end
        end
      end
      column do
        panel "Users who have completed profile" do
          figure class: 'headline-number' do
            link_to User.profile_complete.count, admin_users_path(scope: 'profile_complete')
          end
        end
      end
    end
    columns do
      column do
        panel "Users who have uploaded audio" do
          figure class: 'headline-number' do
            link_to User.where.associated(:pronunciation_attachment).count, admin_users_path(scope: 'has_audio')
          end
        end
      end
      column do
        panel "Sign-up rate (per week; over last 4 weeks)" do
          figure class: 'headline-number' do
            span User.created_since(4.weeks.ago).count / 4
          end
        end
      end
    end
  end # content
end
