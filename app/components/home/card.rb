class Components::Home::Card < Components::Base
  def initialize(user)
    @user = user
  end

  def view_template
    SectionCard(t('.title'), tone: section, id: section.to_s.dasherize, class: 'dashboard-card') do |card|
      card.tool { edit_button }
      card.content do
        Blurb(blurb) if blurb
        content
      end
      card.actions { actions }
    end
  end

  private

  def step = section

  def blurb = t("profile.#{step}.blurb")

  def actions = nil

  def edit_button
    IconButton(profile_path(step), icon: 'pencil', label: t('actions.edit'), class: 'dashboard-card__edit text-secondary')
  end

  def attribute(list, name, required: false)
    list.item(User.human_attribute_name(name)) { value(name, required:) }
  end

  def value(name, required: false)
    @user.public_send(:"#{name}?") ? plain(@user.public_send(name)) : MissingValue(required:)
  end
end
