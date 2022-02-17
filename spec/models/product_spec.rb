require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { build(:product) }

  it { is_expected.to be_valid }

  context 'validations' do
    it 'validates presence of sku' do
      subject.sku = nil
      expect(subject).to be_invalid
    end

    it 'validates presence of name' do
      subject.name = nil
      expect(subject).to be_invalid
    end

    it 'validates presence of cost_price' do
      subject.cost_price = nil
      expect(subject).to be_invalid
    end

    it 'validates value of cost_price greater than 0' do
      subject.cost_price = -1.9
      expect(subject).to be_invalid
    end
  end
end
