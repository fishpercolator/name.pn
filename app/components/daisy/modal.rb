class Components::Daisy::Modal < Components::Base
  def initialize(title, open: false, **attributes)
    @title = title
    @open = open
    @attributes = attributes
  end

  def view_template(&)
    dialog(**mix({ class: 'modal', open: @open }, @attributes)) do
      div(class: 'modal-box') do
        form(method: 'dialog') do
          CloseButton(type: :submit, class: 'absolute top-2 right-2')
        end
        h3(class: 'text-lg font-bold') { @title }
        yield
      end
      form(method: 'dialog', class: 'modal-backdrop') do
        button { t('actions.close') }
      end
    end
  end
end
