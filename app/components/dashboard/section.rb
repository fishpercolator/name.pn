class Components::Dashboard::Section < Components::Base
  def initialize(user)
    @user = user
  end

  def view_template
    DashboardCard(t('.title'), tone: section_name, id: section_name.to_s.dasherize, class: 'dashboard-card') do |card|
      card.tool(profile_path(step), icon: 'pencil', label: t('actions.edit'), class: 'dashboard-card__edit text-secondary')
      card.content do
        Blurb(blurb) if blurb
        content
      end
      actions(card)
    end
  end

  protected

  def step = section_name

  def blurb = t("profile.#{step}.blurb")

  def actions(card) = nil
end
