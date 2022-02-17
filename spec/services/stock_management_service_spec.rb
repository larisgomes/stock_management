require 'rails_helper'

RSpec.describe StockManagementService do
  let(:product) { create(:product) }
  let(:store) { create(:store) }
  let(:amount) { 3 }

  subject { described_class.new(stock_item.id, amount) }

  context 'when there is amount of items available' do
    let(:stock_item) { create(:stock_item, :available, product: product, store: store) }

    context 'when adding items' do
      it 'updated amount value' do
        expect(subject.update_stock('add')).to eq(true)

        stock_item.reload
        expect(stock_item.amount).to eq(13)
      end
    end

    context 'when removing items' do
      it 'updated amount value' do
        expect(subject.update_stock('remove')).to eq(true)

        stock_item.reload
        expect(stock_item.amount).to eq(7)
      end
    end
  end

  context 'when there is not amount of items available' do
    let(:stock_item) { create(:stock_item, :unavailable, product: product, store: store) }

    let(:unavailable_amount) do
      {
        error: 'Quantidade de items indisponível.'
      }
    end

    it 'does not updated amount value' do
      expect(subject.update_stock('remove')).to eq(unavailable_amount)

      stock_item.reload
      expect(stock_item.amount).to eq(0)
    end
  end
end
