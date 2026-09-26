class Views::Profile::Slug < Views::Profile::Step
  def view_template
    wizard_step(section_name: :url, required: true) do |form|
      form.field :slug, prefix: root_url
      form.checkbox :noindex
      subheading t('.the_rest_is_optional')
      Blurb(t('.optional_blurb'))
      save_and_exit_button { t('.save_and_exit') }
      Blurb(t('.or_continue'))
    end
  end
end
