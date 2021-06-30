class LinkBlueprint < Blueprinter::Base
  fields :title, :url
  
  # OpenAPI schema for this blueprint
  SCHEMA = {
    type: :object,
    required: %i[title url],
    properties: {
      title: {
        type: :string,
        description: 'The title of the link',
        example: 'Twitter'
      },
      url: {
        type: :string,
        description: 'The link URL',
        example: 'https://example.com/AbbyYates'
      }
    }
  }
  
end
