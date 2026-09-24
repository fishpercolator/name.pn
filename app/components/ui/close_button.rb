class Components::UI::CloseButton < Components::Base
  def initialize(**attributes)
    @attributes = attributes
  end

  def view_template
    Button(shape: :circle, size: :xs, **mix(appearance, @attributes)) do
      Icon('close', class: 'size-4 fill-current')
    end
  end

  private

  def appearance
    { class: 'border-0 bg-base-content/40 text-base-100 hover:bg-base-content/60', aria: { label: t('actions.close') } }
  end
end
