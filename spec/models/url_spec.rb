require "rails_helper"

RSpec.describe Url, :type => :model do
  it "can shorten a url" do
    url = Url.create(original: "www.google.com")

    shortened = url.shorten

    expect(shortened).to eq("191347")
  end

  it "can shorten another url" do
    url = Url.create(original: "www.google.com/abcdefg")

    shortened = url.shorten

    expect(shortened).to eq("8a08d6")
  end
end
