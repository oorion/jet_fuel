class Url < ActiveRecord::Base
  def shorten(host_with_port)
    host_with_port + "/abc"
  end
end
