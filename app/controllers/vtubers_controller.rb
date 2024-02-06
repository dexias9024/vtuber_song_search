class VtubersController < ApplicationController
  def show
    @vtuber = Vtuber.find(params[:id])
    @songs = @vtuber.songs.order(created_at: :desc).page(params[:page])
  end

  def index
    @vtubers = Vtuber.all.order(created_at: :desc).page(params[:page])
  end
end
