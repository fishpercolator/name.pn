class Components::UI::FlashMessages < Components::Base
  include Phlex::Rails::Helpers::Flash

  TONES = { 'notice' => 'bg-info/20', 'alert' => 'bg-error/20' }.freeze

  def render? = messages.any?

  def view_template
    section(id: 'messages', data: { controller: 'messages' }) do
      messages.each { |type, text| message(type, text) }
    end
  end

  private

  def messages = flash.to_hash.slice(*TONES.keys)

  def message(type, text)
    div(class: TONES.fetch(type), role: 'alert') do
      div(class: 'container mx-auto flex items-center justify-between gap-4 px-4 py-5') do
        span { text }
        CloseButton(class: 'messages__close', data: { action: 'messages#close' })
      end
    end
  end
end
