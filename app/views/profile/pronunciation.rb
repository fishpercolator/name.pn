class Views::Profile::Pronunciation < Views::Profile::Step
  register_value_helper :params

  def view_template
    wizard_step(controller: 'pronunciation-form') do |form|
      form.select :pronunciation_of, choices: @user.pronunciation_of_options, data: { action: 'pronunciation-form#changeChoice' }
      form.field :phonetic, label: t('.phonetic_html', name: chosen_name)
      Fieldset do
        span(class: 'fieldset-legend block') { t('.record_html', name: chosen_name) }
        render Components::Wizard::Recorder.new(form, mock_permission: params[:mock_permission])
      end
      form.field :ipa, class: 'font-ipa'
    end
  end

  private

  def chosen_name = capture { span(data: { pronunciation_form_target: 'output' }) { @user.pronunciation_of_name } }.html_safe
end
