require "rails_helper"

RSpec.describe Url, :type => :model do
  it "can shorten a url" do
    url = Url.create(original: "http://www.google.com")

    shortened = url.shorten

    expect(shortened).to eq("253d14")
  end

  it "can shorten another url" do
    url = Url.create(original: "http://www.google.com/abcdefg")

    shortened = url.shorten

    expect(shortened).to eq("1153d1")
  end

  it "must have a unique original address" do
    url1 = Url.create(original: "www.google.com")
    url2 = Url.create(original: "www.google.com")

    expect(url1.save).to eq(true)
    expect(url2.save).to eq(false)
  end

  it "has a count" do
    url = Url.create(original: "www.google.com")

    expect(url.count).to eq(1)
  end

  it "can increment its count" do
    url = Url.create(original: "www.google.com")

    url.increment_count

    expect(url.count).to eq(2)
  end

  it "can shorten urls that happen to have the same hash" do
    url1 = Url.create(original: "www.google.com")
    url2 = Url.create(original: "www.blah.com")
    Digest::SHA256.stub(:hexdigest) { "253d14" }
    Random.stub(:rand) { 0 }

    url1.update(shortened: url1.shorten)
    url2.update(shortened: url2.shorten)

    expect(url1.shortened).to eq("253d14")
    expect(url2.shortened).to eq("253d140")
  end
end
