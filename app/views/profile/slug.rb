class Views::Profile::Slug < Views::Profile::Step
  protected

  def section_name = :url

  def required? = true

  def fields(form)
    form.field :slug, prefix: root_url
    form.checkbox :noindex
    subheading(t('.the_rest_is_optional'))
    Blurb(t('.optional_blurb'))
    save_and_exit(form, t('.save_and_exit'))
    Blurb(t('.or_continue'))
  end
end
