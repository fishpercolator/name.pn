class Components::UI::FieldError < Components::Base
  def initialize(message)
    @message = message
  end

  def render? = @message.present?

  def view_template
    p(class: 'error text-sm text-error') { @message }
  end
end
