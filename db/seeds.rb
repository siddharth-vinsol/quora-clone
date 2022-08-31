User.delete_all
User.create(name: 'user1', email: 'user1@user.com', password: 'password', password_confirmation: 'password', verified: SecureRandom.uuid)
User.create(name: 'user2', email: 'user2@user.com', password: 'password', password_confirmation: 'password', verified: SecureRandom.uuid)
User.create(name: 'user3', email: 'user3@user.com', password: 'password', password_confirmation: 'password', verified: SecureRandom.uuid)
