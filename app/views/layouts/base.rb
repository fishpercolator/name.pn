class Views::Layouts::Base < Views::Base
  include Phlex::Rails::Layout

  protected

  def document(body_class, &)
    doctype
    html(lang: 'en') do
      head { render Components::Shared::SiteHead.new }
      body(class: body_class, &)
    end
  end
end
