class UrlsController < ApplicationController
  def index
    @host_with_port = request.host_with_port
    @url = Url.new
    @urls = Url.sort_by_popularity
  end

  def create
    url = Url.find_by(url_params)
    if url
      url.increment_count
      redirect_to root_path
    else
      url = Url.new(url_params)
      if url.save
        url.update(shortened: url.shorten)
        redirect_to root_path
      else
        render :index, notice: "Invalid url"
      end
    end
  end

  private

  def url_params
    params.require(:url).permit(:original)
  end
end
