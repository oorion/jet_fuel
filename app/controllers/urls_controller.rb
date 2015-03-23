class UrlsController < ApplicationController
  def index
    @url = Url.new
    @urls = Url.all
  end

  def create
    url = Url.new(url_params)
    if url.save
      shortened = url.shorten(request.host_with_port)
      url.update(shortened: shortened)
      redirect_to root_path
    else
      render :index, notice: "Invalid url"
    end
  end

  private

  def url_params
    params.require(:url).permit(:original)
  end
end
