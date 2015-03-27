class UrlsController < ApplicationController
  def index
    @host_with_port = request.host_with_port
    @url = Url.new
    if params[:sort] == "popularity"
      @urls = Url.sort_by_popularity
    elsif params[:sort] == "date"
      @urls = Url.sort_by_date
    else
      @urls = Url.all
    end
  end

  def create
    url = Url.find_by(url_params)
    if url
      url.increment_count
      redirect_to root_path
    else
      url = Url.new(url_params)
      if url.save
        TitleWorker.perform_async(url.original)
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
