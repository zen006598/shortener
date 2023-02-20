require 'rails_helper'
require 'capybara/rspec'

feature "Shortener", type: :feature do
  let!(:url) {create(:url)}
  describe 'When input URL' do
    scenario "successed" do
      visit root_path
      fill_in "網址：", with: url.original
      click_button "送出"
      expect(page).to have_content("原始網址：#{url.original}")
      expect(page.find("#url").value).to eq("http://127.0.0.1:3001/#{url.slug}")
    end
  end

  describe 'When visit original URL' do
    scenario "successd" do
      visit "http://localhost:3001/#{url.slug}"
      expect(page).to have_current_path(url.original)
    end
  end
 
end