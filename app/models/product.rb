class Product < ApplicationRecord
  has_many :stock_item, dependent: :destroy

  validates_presence_of :sku, :name, :cost_price
  validates_uniqueness_of :sku, message: 'Produto com esse código já existe '
  validates_numericality_of :cost_price, :greater_than => 0
end
