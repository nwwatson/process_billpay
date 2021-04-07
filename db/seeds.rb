User.create!(
  email: 'admin@test.com',
  first_name: 'System',
  last_name: 'Administrator',
  password: 'changeME123!',
  password_confirmation: 'changeME123!',
  admin: true
)

SyncPcPeople.call