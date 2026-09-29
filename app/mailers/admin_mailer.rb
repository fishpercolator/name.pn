class AdminMailer < ApplicationMailer
  def buttondown_failed
    return if admins.empty?

    mail(to: admins) do |format|
      format.text { render plain: t(".body", **params) }
    end
  end

  private

  def admins = User.role_admin.pluck(:email)
end
