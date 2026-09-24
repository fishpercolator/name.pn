class Views::Profile::Step < Views::Base
  register_value_helper :step
  register_value_helper :wizard_steps
  register_value_helper :wizard_path
  register_value_helper :previous_wizard_path
  register_value_helper :next_step
  register_value_helper :previous_step

  controller_variable :user

  def view_template
    set_meta_tags(title: step_title)
    Form(model: @user, url: wizard_path, method: :patch) do |form|
      progress(form)
      section(class: 'container mx-auto px-4 py-8') { card(form) }
    end
  end

  protected

  def section_name = step

  def required? = false

  def controller = nil

  private

  def step_title = t('.title')

  def card(form)
    DashboardCard(step_title, heading: :h1, tone: section_name, id: section_name.to_s.dasherize, class: 'profile-form mx-auto md:w-1/2') do |card|
      card.content do
        Blurb(*blurbs, requirement)
        div(class: 'space-y-2', data: { controller: }) { fields(form) }
        navigation(form)
      end
    end
  end

  def blurbs = Array(t('.blurb'))

  def requirement = t(required? ? 'profile.step.required' : 'profile.step.optional')

  def progress(form)
    section(class: 'container mx-auto flex items-start gap-4 px-4 pt-8') do
      div(class: 'grow overflow-x-auto') { steps }
      save_and_exit(form, t('profile.step.save_and_exit')) if navigable?
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

  def save_and_exit(form, text)
    form.submit(text, name: 'button', value: 'finish', variant: nil, outline: true, icon: 'content-save', class: 'shrink-0')
  end

  def navigation(form)
    nav(class: 'mt-8 flex items-center justify-between gap-2') do
      div { back_button if previous_step != step }
      last_step? ? finish_button(form) : next_button(form)
    end
  end

  def last_step? = next_step == Wicked::FINISH_STEP

  def back_button = Button(href: previous_wizard_path, icon: 'chevron-left') { t('profile.step.previous') }

  def next_button(form) = form.submit(t('profile.step.next'), trailing_icon: 'chevron-right')

  def finish_button(form)
    form.submit(t('profile.step.finish'), name: 'button', value: 'finish', variant: :primary, trailing_icon: 'page-last')
  end

  def subheading(text) = h2(class: 'mt-4 text-lg font-bold') { text }

  def choices(values, scope:) = values.map { [t(it, scope:), it] }
end
