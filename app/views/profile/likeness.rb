class Views::Profile::Likeness < Views::Profile::Step
  protected

  def fields(form)
    render Components::Profile::LikenessUploader.new(form)
  end
end
