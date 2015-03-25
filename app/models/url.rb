class Url < ActiveRecord::Base
  validates :count, presence: true
  validates :original, uniqueness: true

  def shorten
    digest = Digest::SHA256.hexdigest(original)[0..5]
    while Url.find_by(shortened: digest)
      digest += Random.rand(0..9).to_s
    end
    digest
  end

  def shortened_url(host_with_port)
    host_with_port + "/" + shortened
  end

  def increment_count
    self.count += 1
    update(count: self.count)
  end

  def self.sort_by_popularity
    all.sort_by(&:count).reverse
  end

  def self.sort_by_date
    all.sort_by(&:updated_at).reverse
  end
end
