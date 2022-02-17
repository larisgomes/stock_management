class StockItem < ApplicationRecord
  belongs_to :product
  belongs_to :store

  validates_uniqueness_of :product_id, :scope => :store_id
  validates_numericality_of :amount, :greater_than_or_equal_to => 0
end
