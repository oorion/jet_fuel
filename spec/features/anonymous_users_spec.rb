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
        expect(page).to have_content("www.google.com | www.example.com/253d14")
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
          expect(page).to have_content("www.bitly.com | www.example.com/625f4b | 2")
        end
        within all("li").last do
          expect(page).to have_content("www.google.com | www.example.com/253d14 | 1")
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
          expect(page).to have_content("www.google.com | www.example.com/253d14 | 2")
        end
        within all("li").last do
          expect(page).to have_content("www.bitly.com | www.example.com/625f4b | 2")
        end
      end
    end

    it "allows a user to search by url" do
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

    xit "can fetch the title of a url using a background worker" do
      # not sure how to get this to work
      visit root_path
      original_url = "http://www.google.com"
      shorten_url(original_url)

      url = Url.find_by(original: original_url)
      Kernel.sleep(10.0)

      expect(url.title).to eq("Google")
    end
  end
end
