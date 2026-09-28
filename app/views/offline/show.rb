class Views::Offline::Show < Views::Base
  register_output_helper :inline_svg_tag

  def view_template
    inline_svg_tag("logo.svg", aria_hidden: true)
    PageTitle(t(".title"))
    p { t(".blurb", product: t("product_name")) }
  end
end
