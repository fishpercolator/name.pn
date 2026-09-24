class Views::Profile::Pronouns < Views::Profile::Step
  controller_variable :additional_ups

  protected

  def required? = true

  def controller = 'pronoun-form'

  def fields(form)
    div(class: 'profile-pronouns space-y-6', data: { pronoun_form_target: 'list' }) do
      form.fields_for(:user_pronoun_sets) { option(it) }
      @additional_ups.each { |ups| form.fields_for(:user_pronoun_sets, ups) { option(it) } }
    end
    Blurb(t('.get_in_touch'), class: 'my-3')
    form.field :pronounless_style, as: :select, choices: choices(User.pronounless_styles.keys, scope: 'pronounless_styles'), include_blank: t('pronounless_styles.na'), data: { pronoun_form_target: 'pronounless', action: 'pronoun-form#changePronounless' }
    form.field :pronoun_style, as: :select, choices: choices(User.pronoun_styles.keys, scope: 'pronoun_styles')
    form.field :pronoun_example, as: :select, choices: choices(User.pronoun_examples.keys, scope: 'pronoun_example_headings')
  end

  private

  def option(row)
    row.hidden :pronoun_set_id
    div(class: 'profile-pronouns__option') do
      label(for: row.id_for(:_destroy), class: 'flex cursor-pointer items-start gap-2 text-xl font-bold') do
        span(class: 'hidden cursor-grab', data: { pronoun_form_target: 'handle' }) { Icon('drag', class: 'size-6 fill-current') }
        row.input :position, as: :number, title: t('.position_hint'), class: 'input-sm w-16', data: { pronoun_form_target: 'position' }
        row.input :_destroy, as: :checkbox, checked: row.object.persisted?, checked_value: '0', unchecked_value: '1', class: 'mt-0.5', data: { pronoun_form_target: 'option' }
        pronoun_set(row.object.pronoun_set)
      end
    end
  end

  def pronoun_set(set)
    span do
      plain set.to_s
      Hint(class: 'hint block font-normal') { example(set) }
    end
  end

  def example(set)
    t('.pronoun_set_hint_html', name: @user.personal_name, nominative: set.nominative, oblique: set.oblique, copula: set.copula)
  end
end
