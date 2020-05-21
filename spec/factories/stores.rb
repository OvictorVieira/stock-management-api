FactoryBot.define do
  factory :store do
    name { Faker::Name.name }
    address { Faker::Address.street_name }
  end
end
