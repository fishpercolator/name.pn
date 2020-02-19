if Rails.env.development?
  User.create!(email: 'admin@example.com', password: 'password', role: :admin)
end

PronounSet.create(nominative: 'he', oblique: 'him', possessive_determiner: 'his', possessive: 'his', reflexive: 'himself', copula: 'is')
PronounSet.create(nominative: 'she', oblique: 'her', possessive_determiner: 'her', possessive: 'hers', reflexive: 'herself', copula: 'is')
PronounSet.create(nominative: 'they', oblique: 'them', possessive_determiner: 'their', possessive: 'theirs', reflexive: 'themself', copula: 'are')
