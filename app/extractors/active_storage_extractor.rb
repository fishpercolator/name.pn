class ActiveStorageExtractor < Blueprinter::Extractor    
  def extract(_field_name, _object, _local_options, _options={})
    attachment = _object.public_send(_field_name)
    if attachment.attached?
      Rails.application.routes.url_helpers.rails_blob_path(attachment, only_path: true)
    else
      nil
    end
  end
end
