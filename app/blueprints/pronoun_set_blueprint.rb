class PronounSetBlueprint < Blueprinter::Base
  fields :nominative, :oblique, :possessive_determiner, :possessive, :reflexive, :copula

  # OpenAPI schema for this blueprint
  SCHEMA = {
    type: :object,
    required: %i[nominative oblique possessive_determiner possessive reflexive copula],
    properties: {
      nominative: {
        type: :string,
        description: 'The nominative case / subject form of this pronoun',
        example: 'they'
      },
      oblique: {
        type: :string,
        description: 'The oblique case / object form of this pronoun',
        example: 'them'
      },
      possessive_determiner: {
        type: :string,
        description: 'The possessive determiner form of this pronoun',
        example: 'their'
      },
      possessive: {
        type: :string,
        description: 'The possessive (non-determiner) form of this pronoun',
        example: 'theirs'
      },
      reflexive: {
        type: :string,
        description: 'The reflexive form of this pronoun',
        example: 'themself'
      },
      copula: {
        type: :string,
        description: 'Which copula form (\'is\' or \'are\') to use with this pronoun',
        example: 'are'
      }
    }
  }

end
