class AlternateNameBlueprint < Blueprinter::Base
  
  fields :name, :category
  
  # OpenAPI schema for this blueprint
  SCHEMA = {
    type: :object,
    required: %i[name category],
    properties: {
      name: {
        type: :string,
        description: 'An alternate name for this user',
        example: 'Abigail',
      },
      category: {
        type: :string,
        enum: %w[like ok sometimes dislike],
        description: 'Whether this user likes to be called by this name: like = likes; ok = does not mind; sometimes = only under specific circumstances; dislike = dislikes'
      }
    }
  }
end
