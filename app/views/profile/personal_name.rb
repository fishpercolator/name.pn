class Views::Profile::PersonalName < Views::Profile::Step
  def view_template
    wizard_step(required: true) do |form|
      form.field :full_name
      form.field :personal_name
    end
  end
end
