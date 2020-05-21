FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email {}
    password { 'Password' }
    password_confirmation { 'Password' }
  end
end
