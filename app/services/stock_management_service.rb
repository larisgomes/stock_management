class StockManagementService
  attr_accessor :amount, :stock

  def initialize(id, amount)
    @stock = find_stock(id)
    @amount = amount.to_i
  end

  def update_stock(operation)
    new_amount = send(operation)
    @stock.update!(amount: new_amount)
  rescue ActiveRecord::RecordInvalid => e
      { error: 'Quantidade de items indisponível.' }
  end

  def add
    @stock.amount += @amount
  end

  def remove
    @stock.amount -= @amount
  end

  private

  def find_stock(id)
    @stock ||= StockItem.find_by(id: id)
  end
end
