class Admin::SongsController < Admin::BaseController
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
    @songs = Song.all.includes(:vtuber).order(created_at: :desc).page(params[:page])
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
end
