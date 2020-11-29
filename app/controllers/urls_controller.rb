class UrlsController < ApplicationController
  before_action :load_url, only: %i[show show_stats]

  def create
    context = Urls::Create.call(params: url_params)

    render json: context.response
  end

  def show
    @url.with_lock do
      @url.increment!(:request_counter)
    end

    redirect_to @url.full_version
  end

  def show_stats
    render json: { request_counter: @url.request_counter }
  end

  private

  def url_params
    params.require(:url).permit(:full_version)
  end

  def load_url
    @url = Url.find_by(short_version: params[:id])
  end
end
