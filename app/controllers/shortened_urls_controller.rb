class ShortenedUrlsController < ApplicationController
  def show
    url = Url.find_by(shortened: params[:shortened])
    redirect_to url.original
  end
end
