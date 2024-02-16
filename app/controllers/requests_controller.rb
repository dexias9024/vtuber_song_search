class RequestsController < ApplicationController
  include RequestsHelper
  before_action :set_instruments, only: %i[new]
  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.user_id = current_user.id
    respond_to do |_format|
      if @request.save
        respond_to(&:html)
        redirect_to new_request_path, success: t('.success')
      else
        respond_to(&:turbo_stream)
        render turbo_stream: turbo_stream.replace('request_form', partial: 'requests/vtuber', locals: { request: @request }), status: :unprocessable_entity
      end
    end
  end

  def vtuber_form
    @request = Request.new
    puts @request.inspect
    respond_to(&:turbo_stream) 
    render turbo_stream: turbo_stream.update('request_form', partial: 'requests/vtuber', locals: { request: @request }), status: :unprocessable_entity
  end

  def song_form
    @request = Request.new
    respond_to(&:turbo_stream) 
    render turbo_stream: turbo_stream.update('request_form', partial: 'requests/song', locals: { request: @request }), status: :unprocessable_entity
  end

  def autocomplete
    @results = search_autocomplete(params[:q])

    respond_to(&:js)
  end

  private

  def request_params
    params.require(:request).permit(:user_id, :category, :name, :url, :member_name, instrument_ids: [])
  end

  def set_instruments
    @instruments = Instrument.all
  end
end
