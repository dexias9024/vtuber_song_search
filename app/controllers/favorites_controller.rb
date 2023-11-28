class FavoritesController < ApplicationController
  def create
    @song = Song.find(params[:song_id])
    current_user.favorites.create!(song_id: @song.id)
    Rails.logger.debug "Favorite created successfully!"
    render turbo_stream: turbo_stream.replace(
      "favorite-button",
      partial: 'songs/favorite_button',
      locals: { song: @song},
    )
  end
 
  def destroy
    @song = Song.find(params[:song_id])
    favorite = current_user.favorites.find_by!(song_id: @song.id)
    favorite.destroy!

    render turbo_stream: turbo_stream.replace(
      "favorite-button",
      partial: 'songs/favorite_button',
      locals: { song: @song},
    )
  end
end
