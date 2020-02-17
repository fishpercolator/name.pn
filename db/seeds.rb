if Rails.env.development?
  User.create!(email: 'admin@example.com', password: 'password', role: :admin)
end
