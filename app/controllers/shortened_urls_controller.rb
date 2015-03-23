class ShortenedUrlsController < ApplicationController
  def show
    url = Url.find_by(shortened: params[:shortened])
    original = "http://" + url.original
    redirect_to original
  end
end
