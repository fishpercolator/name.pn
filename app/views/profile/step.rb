class Views::Profile::Step < Views::Base
  register_value_helper :step
  register_value_helper :wizard_steps
  register_value_helper :wizard_path
  register_value_helper :previous_wizard_path
  register_value_helper :next_step
  register_value_helper :previous_step

  controller_variable :user

  private

  def wizard_step(section_name: step, required: false, controller: nil)
    set_meta_tags(title: t('.title'))
    Form(model: @user, url: wizard_path, method: :patch) do |form|
      progress
      section(class: 'container mx-auto px-4 py-8') do
        DashboardCard(t('.title'), heading: :h1, tone: section_name, id: section_name.to_s.dasherize, class: 'profile-form mx-auto md:w-1/2') do |card|
          card.content do
            Blurb(*Array(t('.blurb')), t(required ? 'profile.step.required' : 'profile.step.optional'))
            div(class: 'space-y-2', data: { controller: }) do
              yield form
            end
            navigation
          end
        end
      end
    end
  end

  def progress
    section(class: 'container mx-auto flex items-start gap-4 px-4 pt-8') do
      div(class: 'grow overflow-x-auto') do
        steps
      end
      save_and_exit_button(class: 'shrink-0') { t('profile.step.save_and_exit') } if navigable?
    end
  end

  def steps
    Steps(class: 'profile-steps') do |steps|
      wizard_steps.each_with_index do |name, index|
        steps.step(t("profile.#{name}.title"), href: (wizard_path(name) if navigable?), done: index <= wizard_steps.index(step))
      end
    end
  end

  def navigable? = @user.basic_names_complete?

  def navigation
    nav(class: 'mt-8 flex items-center justify-between gap-2') do
      div { back_button unless previous_step == step }
      next_step == Wicked::FINISH_STEP ? finish_button : next_button
    end
  end

  def back_button = Button(href: previous_wizard_path, icon: 'chevron-left') { t('profile.step.previous') }

  def next_button = Button(type: :submit, variant: :secondary, trailing_icon: 'chevron-right') { t('profile.step.next') }

  def finish_button
    Button(type: :submit, name: 'button', value: 'finish', variant: :primary, trailing_icon: 'page-last') { t('profile.step.finish') }
  end

  def save_and_exit_button(**, &)
    Button(type: :submit, name: 'button', value: 'finish', outline: true, icon: 'content-save', **, &)
  end

  def subheading(text) = h2(class: 'mt-4 text-lg font-bold') { text }

  def choices(values, scope:) = values.map { [t(it, scope:), it] }
end
