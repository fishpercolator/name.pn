class Components::Daisy::FileInput < Components::Daisy::Field
  def view_template
    @builder.file_field(@attribute, **mix({ class: ['file-input', ('file-input-error' if error?)] }, @attributes))
  end
end
