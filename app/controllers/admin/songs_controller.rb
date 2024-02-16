class Admin::SongsController < Admin::BaseController
  include SongsHelper
  before_action :set_song, only: %i[show edit update destroy]
  before_action :set_vtubers, only: %i[new edit update]
  
  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      flash[:success] = t('.success')
      redirect_to admin_songs_path
    else
      flash[:danger] = @song.errors.full_messages
      redirect_to action: :new
    end
  end

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

  def show; end

  def edit; end

  def update
    if @song.update(song_params)
      redirect_to admin_songs_path, success: t('.success')
    else
      flash[:danger] = @song.errors.full_messages
      redirect_to action: :edit
    end
  end

  def destroy
    @song.destroy!
    redirect_to admin_songs_path, success: t('.success')
  end

  private

  def set_song
    @song = Song.find(params[:id])
  end

  def set_vtubers
    @vtubers = Vtuber.all
  end

  def song_params
    params.require(:song).permit(:title, :cover, :name, :artist_name, :vtuber_id, :video_url)
  end

  def search_params
    params.permit(:search, :title, :name, :artist_name, :cover_eq, :cover)
  end
end
