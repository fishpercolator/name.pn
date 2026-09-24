class Components::Profile::Recorder < Components::Base
  include Phlex::Rails::Helpers::URLFor

  NO_JS = 'recorder__nojs in-[.recorder--granted]:hidden in-[.recorder--prompt]:hidden in-[.recorder--denied]:hidden'.freeze
  STATES = { recorder_granted_class: 'recorder--granted', recorder_prompt_class: 'recorder--prompt', recorder_denied_class: 'recorder--denied' }.freeze

  def initialize(form, mock_permission: nil)
    @form = form
    @mock_permission = mock_permission
  end

  def view_template
    div(class: 'recorder space-y-2', data: { controller: 'recorder', recorder_mock_permission_value: @mock_permission, **STATES }) do
      upload_fields
      controls
      @form.error :pronunciation
      Hint(size: :sm, class: 'hint') { t('.hint') }
      permission_prompt
      Alert(tone: :error, icon: 'alert', class: 'recorder__denied hidden in-[.recorder--denied]:flex') { t('.denied') }
      Alert(tone: :warning, icon: 'alert', class: 'recorder__unavailable in-[.recorder--granted]:hidden in-[.recorder--prompt]:hidden in-[.recorder--denied]:hidden') { t('.unavailable') }
    end
  end

  private

  def user = @form.object

  def upload_fields
    @form.fields_for(:pronunciation) do |audio|
      audio.field :data, as: :file, accept: 'audio/wav', capture: '', data: { recorder_target: 'field', action: 'recorder#recorded' }, fieldset: { class: NO_JS }
      audio.checkbox :delete, include_hidden: false, data: { recorder_target: 'deleteFlag' }, fieldset: { class: NO_JS }
    end
  end

  def controls
    div(class: 'recorder__available hidden in-[.recorder--granted]:block') do
      div(class: 'flex select-none flex-col gap-2 xl:flex-row xl:[&>*]:flex-1 [&_.btn]:w-full [&_.btn]:font-normal [&_.btn]:whitespace-nowrap') do
        record_button
        Player(recording_url, variant: :success, size: :lg, data: { recorder_target: 'player' })
        Button(variant: :secondary, size: :lg, icon: 'delete', disabled: true, data: { recorder_target: 'delete', action: 'recorder#delete' }) { t('.delete') }
      end
    end
  end

  def recording_url
    url_for(user.pronunciation) if user.pronunciation.attached? && user.errors[:pronunciation].none?
  end

  def record_button
    Button(variant: :primary, size: :lg, class: 'recorder__button [&.is-active]:cursor-progress [&.is-waiting]:cursor-wait', data: { recorder_target: 'button', action: 'pointerdown->recorder#start pointerup->recorder#stop pointerleave->recorder#stop' }) do
      Icon('record-circle', class: 'size-[1em] fill-current in-[.is-active]:animate-pulse in-[.is-waiting]:hidden')
      Icon('timer-sand', class: 'hidden size-[1em] fill-current in-[.is-waiting]:inline')
      span(class: 'in-[.is-active]:hidden in-[.is-waiting]:hidden') { t('.record') }
      span(class: 'hidden in-[.is-waiting]:inline') { t('.please_wait') }
      span(class: 'hidden in-[.is-active]:inline') { t('.recording') }
    end
  end

  def permission_prompt
    div(class: 'recorder__prompt-form hidden space-y-2 in-[.recorder--prompt]:block') do
      Button(variant: :secondary, size: :lg, icon: 'microphone-question', class: 'recorder__prompt h-auto w-full py-2', data: { action: 'recorder#prompt' }) { t('.prompt') }
      Hint(size: :sm, class: 'hint') { t('.prompt_hint') }
    end
  end
end
