require 'rails_helper'
require 'capybara/rspec'

feature "Shortener", type: :feature do
  scenario "Shortens a URL" do
    url = "https://stackoverflow.com/questions/70685399/ruby-on-rails-7-0-1-and-tailwind-3-tailwind-classes-are-not-being-displayed-in"
    slug = SecureRandom.uuid[0..5]
    visit root_path
    fill_in "網址：", with: url
    click_button "送出"
    expect(page).to have_content("原始網址：#{url}")
  end

  scenario "Visits a short link"  do
    url = create(:url)
    visit "http://localhost:3001/#{url.slug}"
    expect(page).to have_current_path(url.original)
  end
end