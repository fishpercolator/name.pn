class Views::Layouts::Base < Views::Base
  include Phlex::Rails::Layout

  private

  def document(body_class, &)
    doctype
    html(lang: 'en') do
      head { SiteHead() }
      body(class: body_class, &)
    end
  end
end
