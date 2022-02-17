FactoryBot.define do
  factory :stock_item, class: StockItem do
    trait :available do
      store
      product
      amount { 10 }
    end

    trait :unavailable do
      store
      product
      amount { 0 }
    end
  end
end
