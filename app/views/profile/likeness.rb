class Views::Profile::Likeness < Views::Profile::Step
  def view_template
    wizard_step { render Components::Wizard::LikenessUploader.new(@user) }
  end
end
