class Url < ActiveRecord::Base
  validates :count, presence: true
  validates :original, uniqueness: true

  def shorten(host)
    jf = ShortenUrl::JetFuel.new(host)
    digest = jf.shorten(original)
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

  def update_data(host_with_port)
    title = TitleWorker.perform_async(original)
    update(shortened: shorten(host_with_port), title: title)
  end

  def self.sort_by_popularity
    all.sort_by(&:count).reverse
  end

  def self.sort_by_date
    all.sort_by(&:updated_at).reverse
  end

  def self.update_params(original_params)
    if original_params[:original].match(/\Ahttp/)
      original_params
    else
      original_params[:original] = "http://" + original_params[:original]
      original_params
    end
  end
end
