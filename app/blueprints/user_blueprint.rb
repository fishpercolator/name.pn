class UserBlueprint < Blueprinter::Base
  identifier :slug
  
  fields :personal_name, :full_name, :formal_name, 
         :envelope_name, :pronunciation_of, :phonetic, :ipa,
         :pronoun_style, :noindex, :pronounless_style
  
  field :pronunciation, extractor: ActiveStorageExtractor
  field :likeness, extractor: ActiveStorageExtractor
  
  association :pronoun_sets_with_preference, blueprint: PronounSetBlueprint, name: :pronoun_sets
  association :links, blueprint: LinkBlueprint
  association :alternate_names, blueprint: AlternateNameBlueprint
  
  # OpenAPI schema for this blueprint
  SCHEMA = {
    type: :object,
    required: %i[
      slug personal_name full_name formal_name 
      envelope_name pronoun_style noindex pronounless_style
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
        description: 'Used when adding this user to a list of names',
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
      pronoun_sets: {
        type: :array,
        description: 'The user\'s pronoun sets - note that this is affected by the value of pronounless_style',
        items: {'$ref': '#/components/schemas/PronounSet'},
        minItems: 1
      },
      pronunciation_of: {
        type: :string,
        enum: %w[full_name personal_name formal_name envelope_name],
        description: 'Which of the fields the pronunciation fields (phonetic, pronunciation and ipa) relate to'
      },
      phonetic: {
        type: :string,
        description: 'Phonetic pronunciation',
        example: 'A-bee YAYTS',
        nullable: true,
      },
      ipa: {
        type: :string,
        description: 'International Phonetic Alphabet pronunciation',
        example: 'ˈabi jeɪts',
        nullable: true,
      },
      pronoun_style: {
        type: :string,
        enum: %w[two three],
        description: 'Whether this user prefers to shorten their pronouns to two (e.g. they/them) or three (e.g. they/them/theirs)'
      },
      pronounless_style: {
        type: :string,
        enum: [nil] + %w[none unknown any],
        description: 'If set to none or unknown, the user prefers to use their name rather than pronouns. If any, the user has no pronoun preference. This value affects the values in pronoun_sets.',
        nullable: true,
      },
      noindex: {
        type: :boolean,
        description: 'If true, this user has expressed a preference for their personal data not to be indexed by search engines.',
        example: false,
      },
      pronunciation: {
        type: :string,
        format: :uri,
        description: 'URL of an audio clip of the pronunciation. **Note**: May be a relative URL and may redirect.',
        example: '/rails/active_storage/blobs/redirect/xxx.wav',
        nullable: true,
      },
      likeness: {
        type: :string,
        format: :uri,
        description: 'URL of an image of the user\'s likeness. **Note**: May be a relative URL and may redirect.',
        example: '/rails/active_storage/blobs/redirect/yyy.jpg',
        nullable: true,
      },
      alternate_names: {
        type: :array,
        items: {'$ref': '#/components/schemas/AlternateName'}
      },
      links: {
        type: :array,
        items: {'$ref': '#/components/schemas/Link'}
      }
    }
  }
end
