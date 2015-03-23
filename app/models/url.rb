class Url < ActiveRecord::Base
  validates :count, presence: true
  validates :original, uniqueness: true

  def shorten
    Digest::SHA256.hexdigest(original)[0..5]
  end

  def shortened_url(host_with_port)
    host_with_port + "/s/" + shortened
  end

  def increment_count
    self.count += 1
    update(count: self.count)
  end

  def self.sort_by_popularity
    all.sort_by(&:count).reverse
  end
end
