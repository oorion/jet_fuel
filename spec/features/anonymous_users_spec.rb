require "rails_helper"

RSpec.describe "AnonymousUsers", type: :feature do
  def shorten_url(url)
    within(".url-shortener") do
      fill_in "url[original]", with: url
    end
    click_link_or_button("Shorten")
  end

  describe "GET /anonymous_users" do
    it "can return a shortened url" do
      visit root_path

      shorten_url("www.google.com")

      within(".url-stats") do
        expect(page).to have_content("www.google.com | www.example.com/s/191347")
      end
    end

    it "can display urls by popularity" do
      visit root_path

      shorten_url("www.google.com")
      shorten_url("www.bitly.com")
      shorten_url("www.bitly.com")

      within(".url-stats") do
        within first("li") do
          expect(page).to have_content("www.bitly.com | www.example.com/s/cf93ca | 2")
        end
        within all("li").last do
          expect(page).to have_content("www.google.com | www.example.com/s/191347 | 1")
        end
      end
    end
  end
end
