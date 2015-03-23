class Url < ActiveRecord::Base
  def shorten(host_with_port)
    digest = Digest::SHA256.hexdigest(original)[0..5]
    host_with_port + "/" + digest
  end
end
