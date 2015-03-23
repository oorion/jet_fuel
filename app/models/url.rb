class Url < ActiveRecord::Base
  def shorten
    Digest::SHA256.hexdigest(original)[0..5]
  end

  def shortened_url(host_with_port)
    host_with_port + "/s/" + shortened
  end
end
