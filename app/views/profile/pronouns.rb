class Views::Profile::Pronouns < Views::Profile::Step
  controller_variable :additional_ups

  def view_template
    wizard_step(required: true, controller: 'pronoun-form') do |form|
      div(class: 'profile-pronouns space-y-6', data: { pronoun_form_target: 'list' }) do
        form.fields_for(:user_pronoun_sets) { render Components::Wizard::PronounOption.new(it) }
        @additional_ups.each { |ups| form.fields_for(:user_pronoun_sets, ups) { render Components::Wizard::PronounOption.new(it) } }
      end
      Blurb(t('.get_in_touch'), class: 'my-3')
      form.field :pronounless_style, as: :select, choices: choices(User.pronounless_styles.keys, scope: 'pronounless_styles'), include_blank: t('pronounless_styles.na'), data: { pronoun_form_target: 'pronounless', action: 'pronoun-form#changePronounless' }
      form.field :pronoun_style, as: :select, choices: choices(User.pronoun_styles.keys, scope: 'pronoun_styles')
      form.field :pronoun_example, as: :select, choices: choices(User.pronoun_examples.keys, scope: 'pronoun_example_headings')
    end
  end
end
