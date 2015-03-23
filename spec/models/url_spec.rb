require 'rails_helper'

RSpec.describe Url, :type => :model do
  it "can shorten a url" do
    url = Url.create(original: "www.google.com")

    shortened_url = url.shorten("localhost:3000")

    expect(shortened_url).to eq("localhost:3000/abc")
  end
end
