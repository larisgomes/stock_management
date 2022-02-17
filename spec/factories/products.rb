FactoryBot.define do
  factory :product, class: Product do
    sku { '9090123123'}
    name { 'chocolate' }
    cost_price { 2.9 }
  end
end
