require 'rails_helper'

RSpec.describe Store, type: :model do
  subject { build(:store) }

  it { is_expected.to be_valid }

  context 'validations' do
    it 'validates presence of name' do
      subject.name = nil
      expect(subject).to be_invalid
    end

    it 'validates presence of cnpj' do
      subject.cnpj = nil
      expect(subject).to be_invalid
    end

    it 'validates format of cnpj' do
      subject.cnpj = "01234-090"
      expect(subject).to be_invalid
    end
  end
end
