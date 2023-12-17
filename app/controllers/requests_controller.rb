class RequestsController < ApplicationController
  before_action :set_instruments, only: %i[new]
  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.user_id = current_user.id
    respond_to do |format|
      if @request.save
        format.html { redirect_to new_request_path, success: t('.success') }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('request_form', partial: 'requests/vtuber', locals: { request: @request }), status: :unprocessable_entity }
      end
    end
  end

  def vtuber_form
    @request = Request.new
    puts @request.inspect
    respond_to do |format|
      format.html { render 'requests/vtuber' }
      format.turbo_stream { render turbo_stream: turbo_stream.update('request_form', partial: 'requests/vtuber', locals: { request: @request }) }
    end
  end

  def song_form
    @request = Request.new
    respond_to do |format|
      format.html { render 'requests/song' }
      format.turbo_stream { render turbo_stream: turbo_stream.update('request_form', partial: 'requests/song', locals: { request: @request }) }
    end
  end

  private

  def request_params
    params.require(:request).permit(:user_id, :category, :name, :url, :member_name, instrument_ids: [])
  end

  def set_instruments
    @instruments = Instrument.all
  end
end
