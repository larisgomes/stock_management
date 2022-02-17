FactoryBot.define do
  factory :address, class: Address do
    store
    street { 'Av paulista' }
    number { '123' }
    neighborhood { 'Bela Vista' }
    city { 'Sao Paulo' }
    state { 'SP' }
    zip { '01234-090' }
  end
end
