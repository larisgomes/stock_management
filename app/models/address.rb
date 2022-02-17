class Address < ApplicationRecord
  belongs_to :store

  validates_format_of :zip, with: /\A\d{5}\-\d{3}\z/, message: 'Formato inválido'
end
