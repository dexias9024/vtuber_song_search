class VtubersController < ApplicationController
  def show
    @vtuber = Vtuber.find(params[:id])
    @q = Song.where(vtuber_id: @vtuber).ransack(params[:q])
    @songs = @q.result(distinct: true).includes(:vtuber).order(created_at: :desc).page(params[:page])
  end

  def index
    @vtubers = Vtuber.all.order(created_at: :desc).page(params[:page])
  end
end
