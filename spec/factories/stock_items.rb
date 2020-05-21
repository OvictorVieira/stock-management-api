FactoryBot.define do
  factory :stock_item do
    quantity { rand(0...1000) }

    association(:store)
    association(:product)
  end
end
