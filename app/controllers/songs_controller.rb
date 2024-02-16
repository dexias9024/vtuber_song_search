class SongsController < ApplicationController
  include SongsHelper
  def index
    if search_params[:search].present?
      result_songs = if search_params[:cover_eq].present?
                       search_songsname_cover(search_params)
                     else
                       search_songsname(search_params)
                     end
      @songs = Kaminari.paginate_array(result_songs).page(params[:page]).per(20)
    else
      if search_params[:cover_eq].present?
        result_songs = Song.search_by_cover(search_params[:cover_eq]).order("RANDOM()").page(params[:page])
        @songs = result_songs
      else
        @songs = Song.all.order("RANDOM()").page(params[:page])
      end
    end
  end

  def show
    @song = Song.find(params[:id])
    @comment = Comment.new
    @comments = @song.comments
  end

  def favorites
    song_ids = current_user.favorites.pluck(:song_id)
    if search_params[:search].present?
      result_songs = if search_params[:cover_eq].present?
                       favorite_search_songsname_cover(search_params)
                     else
                       favorite_search_songsname(search_params)
                     end
      @favorites = Kaminari.paginate_array(result_songs).page(params[:page]).per(20)
    else
      if search_params[:cover_eq].present?
        result_songs = Song.where(id: song_ids).search_by_cover(search_params[:cover_eq]).order("RANDOM()").page(params[:page])
        @favorites = result_songs
      else
        @favorites = Song.where(id: song_ids).page(params[:page])
      end
    end
  end

  def autocomplete
    @results = search_autocomplete(params[:q])
    respond_to do |format|
      format.js
    end
  end

  private

  def search_params
    params.permit(:search, :title, :name, :artist_name, :cover_eq, :cover)
  end
end
