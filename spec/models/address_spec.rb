require 'rails_helper'

RSpec.describe Address, type: :model do
  subject { build(:address) }

  it { is_expected.to be_valid }

  context 'validations' do
    it 'validates format of zip' do
      subject.zip = "090123"
      expect(subject).to be_invalid
    end

  end
end
