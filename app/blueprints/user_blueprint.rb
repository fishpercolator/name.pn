class UserBlueprint < Blueprinter::Base
  identifier :slug
  
  fields :personal_name, :full_name, :formal_name, :envelope_name

  # OpenAPI schema for this blueprint
  SCHEMA = {
    type: :object,
    required: %i[
      slug personal_name full_name formal_name 
      envelope_name
    ],
    properties: {
      slug: {
        type: :string, 
        description: 'This user\'s unique slug', 
        example: 'abby-yates'
      },
      personal_name: {
        type: :string, 
        description: 'Used when addressing this user in conversation', 
        example: 'Abby'
      },
      full_name: {
        type: :string, 
        description: 'Used when adding this user to a list of names', description: 'The name this user uses on a list of names', 
        example: 'Abby Yates'
      },
      formal_name: {
        type: :string,
        description: 'Used in formal contexts such as the opening of a letter', 
        example: 'Dr Yates', 
        nullable: true
      },
      envelope_name: {
        type: :string,
        description: 'Used when adding this name to an address',
        example: 'Dr Abigail L. Yates',
        nullable: true
      },
    }
  }
end
