FactoryBot.define do
  factory :user do
    name { 'user1' }
    email { 'user1@user.com' }
    username { 'user1' }
    password { 'Password@123' }
    password_confirmation { 'Password@123' }
  end
end
