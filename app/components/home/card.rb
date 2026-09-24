class Components::Home::Card < Components::Base
  def initialize(user)
    @user = user
  end

  def view_template
    DashboardCard(t('.title'), tone: section, id: section.to_s.dasherize, class: 'dashboard-card') do |card|
      card.tool(profile_path(step), icon: 'pencil', label: t('actions.edit'), class: 'dashboard-card__edit text-secondary')
      card.content do
        Blurb(blurb) if blurb
        content
      end
      actions(card)
    end
  end

  protected

  def step = section

  def blurb = t("profile.#{step}.blurb")

  def actions(card) = nil
end
