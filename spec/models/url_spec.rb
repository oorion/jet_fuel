require "rails_helper"

RSpec.describe Url, :type => :model do
  it "can shorten a url" do
    url = Url.create(original: "www.google.com")

    shortened_url = url.shorten("localhost:3000")

    expect(shortened_url).to eq("localhost:3000/191347")
  end

  it "can shorten another url" do
    url = Url.create(original: "www.google.com/abcdefg")

    shortened_url = url.shorten("localhost:3000")

    expect(shortened_url).to eq("localhost:3000/8a08d6")
  end
end
