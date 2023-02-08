class UrlsController < ApplicationController
  before_action :exist_url, only: %w[create]
  before_action :find_url, only: %w[show]
  
  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    if @url.save

      value = {original: @url.original}
      key = "#{@url.id}:#{@url.slug}"
      $redis.hset(key, value)s
      expire(key)
      redirect_to @url
    else
      render :new
    end
  end

  def expire(id)
    $redis.expire(id, 7.days)
  end
  
  def show
    @short_url = "#{request.base_url || ENV['DOMAIN']}/#{@url.slug}"
  end

  def redirect
    key = $redis.keys("*#{params[:slug]}").first

    if key
      original = $redis.hget(key, "original")
      redirect_to original, allow_other_host: true
    else
      redirect_to Url.find_by(slug: params[:slug]).original, allow_other_host: true || root_path
    end
  end

  private

  def url_params
    params.require(:url).permit(:original, :slug)
  end

  def find_url
    @url = Url.find(params[:id])
  end

  def exist_url
    original = Url.find_by(original: url_params[:original])
    redirect_to url_path(original.id), allow_other_host: true if original.present?
  end
end
