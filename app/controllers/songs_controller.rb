class SongsController < ApplicationController
  def index
    @q = Song.ransack(params[:q])
    @songs = @q.result.includes(:vtuber).order("RANDOM()").page(params[:page])
  end

  def show
    @song = Song.find(params[:id])
    @comment = Comment.new
    @comments = @song.comments
  end

  def favorites
    song_ids = current_user.favorites.pluck(:song_id)
    @q = Song.where(id: song_ids).ransack(params[:q])
    @favorites = @q.result.includes(:favorites).order(created_at: :desc).page(params[:page])
  end
end
