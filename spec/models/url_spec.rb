require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'When input url' do
    let!(:url) { create(:url) }

    it 'Sussecced' do
      expect(Url.count).to eq 1
    end

    it 'Failed' do
      Url.new(original: url.original)
      expect(Url.count).to eq 1
    end
  end

  describe 'Validation' do
    it { should validate_presence_of(:original) }
    it {should validate_uniqueness_of(:slug)}
  end
end
