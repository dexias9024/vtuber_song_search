class SongsController < ApplicationController
  def index
    @songs = Song.all.includes(:vtuber).order(created_at: :desc).page(params[:page])
  end

  def show
    @song = Song.find(params[:id])
    @comment = Comment.new
    @comments = @song.comments
  end

  def favorites
    @favorites = current_user.favorites.includes(:song).order(created_at: :desc).page(params[:page])
  end
end
