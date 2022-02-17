class Store < ApplicationRecord
  has_one :address
  has_many :stock_item, dependent: :destroy

  accepts_nested_attributes_for :address

  validates_presence_of :name, :cnpj
  validates_uniqueness_of :cnpj, message: 'Número já cadastrado'
  validates_format_of :cnpj, with: /\A\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}\z/, message: 'Formato inválido'
end
