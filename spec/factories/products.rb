FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    cost_price { rand(1.00...1000.00) }
  end
end
