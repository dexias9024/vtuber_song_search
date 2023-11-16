class SongsController < ApplicationController
  def index
    @songs = Song.all.includes(:vtuber).order(created_at: :desc).page(params[:page])
  end

  def show
    @song = Song.find(params[:id])
  end
end
