require 'rails_helper'

RSpec.describe "AnonymousUsers", :type => :feature do
  describe "GET /anonymous_users" do
    it "can return a shortened url" do
      visit root_path

      within(".url-shortener") do
        fill_in "url[original]", with: "www.google.com"
      end
      click_link_or_button("Shorten")

      within(".url-stats") do
        expect(page).to have_content("www.google.com | www.example.com/191347")
      end
    end
  end
end
