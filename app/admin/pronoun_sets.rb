ActiveAdmin.register PronounSet do
  permit_params :nominative, :oblique, :possessive_determiner, :possessive, :reflexive, :copula
end
