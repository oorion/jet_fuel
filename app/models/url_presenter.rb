class UrlPresenter
  attr_reader :host_with_port, :url, :urls

  def initialize(host_with_port, sort_param)
    @host_with_port = host_with_port
    @url = Url.new
    if sort_param == "popularity"
      @urls = Url.sort_by_popularity
    elsif sort_param == "date"
      @urls = Url.sort_by_date
    else
      @urls = Url.all
    end
  end
end
