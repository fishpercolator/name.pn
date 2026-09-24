class Views::Profile::PersonalName < Views::Profile::Step
  protected

  def required? = true

  def fields(form)
    form.field :full_name
    form.field :personal_name
  end
end
