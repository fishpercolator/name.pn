class PronounsInput < SimpleForm::Inputs::CollectionCheckBoxesInput

  def build_nested_boolean_style_item_tag(collection_builder)
    hint = raw I18n.t('pronoun_set_hint', name: object.personal_name, nominative: collection_builder.object.nominative, oblique: collection_builder.object.oblique, copula: collection_builder.object.copula)
    collection_builder.check_box + collection_builder.text.to_s + content_tag(:p, hint, class: 'help')
  end

  def input_type
    'check_boxes'
  end

end
