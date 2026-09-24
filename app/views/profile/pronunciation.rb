class Views::Profile::Pronunciation < Views::Profile::Step
  register_value_helper :params

  protected

  def controller = 'pronunciation-form'

  def fields(form)
    form.field :pronunciation_of, as: :select, choices: @user.pronunciation_of_options, data: { action: 'pronunciation-form#changeChoice' }
    form.field :phonetic, label: t('.phonetic_html', name: chosen_name)
    Fieldset do
      span(class: 'fieldset-legend block') { t('.record_html', name: chosen_name) }
      render Components::Profile::Recorder.new(form, mock_permission: params[:mock_permission])
    end
    form.field :ipa, class: 'font-ipa'
  end

  private

  def chosen_name = capture { span(data: { pronunciation_form_target: 'output' }) { @user.pronunciation_of_name } }.html_safe
end
