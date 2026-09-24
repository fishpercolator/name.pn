class Components::UI::MissingValue < Components::Base
  def initialize(required: false)
    @required = required
  end

  def view_template
    @required ? required : not_set
  end

  private

  def required
    span(class: 'inline-flex items-center gap-1 font-bold text-warning') do
      Icon('alert', class: 'size-6 fill-current')
      plain t('.required')
    end
  end

  def not_set
    span(class: 'italic text-muted') { t('.not_set') }
  end
end
