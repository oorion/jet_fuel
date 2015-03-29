require "rails_helper"

RSpec.describe ShortenedUrlsController, :type => :controller do
  it "can redirect to an external site" do
    url = Url.create(original: "www.google.com")
    url.update(shortened: url.shorten("www.example.com"))

    get :show, shortened: url.shortened

    expect(response.status).to eq(302)
    expect(response.body).to include("redirect")
  end
end
