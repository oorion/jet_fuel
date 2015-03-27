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
        redirect_to root_path, notice: "Invalid url"
      end
    end
  end

  private

  def url_params
    original_params = params.require(:url).permit(:original)
    update_params(original_params)
  end

  def update_params(original_params)
    if original_params[:original].match(/\Ahttp/)
      original_params
    else
      original_params[:original] = "http://" + original_params[:original]
      original_params
    end
  end
end
