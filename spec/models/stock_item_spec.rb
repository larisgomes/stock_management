require 'rails_helper'

RSpec.describe StockItem, type: :model do
  let(:product) { create(:product) }
  let(:store) { create(:store) }

  subject { build(:stock_item, :available, product: product, store: store) }

  it { is_expected.to be_valid }

  context 'validations' do
    it 'validates presence of product id' do
      subject.product_id = nil
      expect(subject).to be_invalid
    end

    it 'validates presence of store id' do
      subject.store_id = nil
      expect(subject).to be_invalid
    end

    it 'validates amount is greater than or equal to 0' do
      subject.amount = -10
      expect(subject).to be_invalid
    end
  end
end
