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
        expect(page).to have_content("www.google.com | www.example.com/191347")
      end
    end

    it "can display urls by popularity" do
      visit root_path

      shorten_url("www.google.com")
      shorten_url("www.bitly.com")
      shorten_url("www.bitly.com")
      click_link_or_button "Sort By Popularity"

      within(".url-stats") do
        within first("li") do
          expect(page).to have_content("www.bitly.com | www.example.com/cf93ca | 2")
        end
        within all("li").last do
          expect(page).to have_content("www.google.com | www.example.com/191347 | 1")
        end
      end
    end

    it "can display urls by how recently they were added" do
      visit root_path

      shorten_url("www.google.com")
      shorten_url("www.bitly.com")
      shorten_url("www.bitly.com")
      shorten_url("www.google.com")
      click_link_or_button "Sort By Date"

      within(".url-stats") do
        within first("li") do
          expect(page).to have_content("www.google.com | www.example.com/191347 | 2")
        end
        within all("li").last do
          expect(page).to have_content("www.bitly.com | www.example.com/cf93ca | 2")
        end
      end
    end

    it "allows a user to search by url" do
      Capybara.ignore_hidden_elements = true
      visit root_path
      shorten_url("www.google.com")
      shorten_url("www.bitly.com")

      within(".search") do
        fill_in "search", with: "google"
      end
      click_link_or_button("Search")

      expect(current_path).to eq(root_path)
      expect(page).to have_content("www.google.com")
      # expect(page).to_not have_content("bitly")
    end
  end
end
