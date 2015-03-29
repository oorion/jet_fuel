class UrlsController < ApplicationController
  def index
    @url_presenter = UrlPresenter.new(request.host_with_port, params[:sort])
  end

  def create
    url = Url.find_by(url_params)
    if url
      url.increment_count
      redirect_to root_path
    else
      url = Url.new(url_params)
      if url.save
        url.update_data(request.host_with_port)
        redirect_to root_path
      else
        redirect_to root_path, notice: "Invalid url"
      end
    end
  end

  private

  def url_params
    original_params = params.require(:url).permit(:original)
    Url.update_params(original_params)
  end
end
