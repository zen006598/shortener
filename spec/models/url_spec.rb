require 'rails_helper'

RSpec.describe Url, type: :model do
  describe '重複網址' do

    before(:each) do
      @url = create(:url)
    end

    it 'input the new url' do
      create(:url)
      expect(Url.count).to eq 2
    end

    it 'input the existing url' do
      original = @url.original
      Url.new(original: original)
      expect(Url.count).to eq 1
    end
  end

  describe '驗證' do
    it { should validate_presence_of(:original) }
    it "Input original url" do
      url = create(:url)
      expect(url).to validate_uniqueness_of(:slug)
    end
  end
end
