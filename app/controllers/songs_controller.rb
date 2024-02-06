class SongsController < ApplicationController
  def index
    if search_params[:search].present?
      key_words = search_params[:search].split(/[\p{blank}\s]+/)
      hiragana = key_words.map { |word| word.tr('ァ-ン', 'ぁ-ん') }
      katakana = key_words.map { |word| word.tr('ぁ-ん', 'ァ-ン') }

      if search_params[:cover_eq].present?
        search_songs = Song.search_by_title_name_artist(key_words).search_by_cover(search_params[:cover_eq]).order(created_at: :desc)
        hiragana_songs = Song.search_by_title_name_artist(hiragana).search_by_cover(search_params[:cover_eq]).order(created_at: :desc)
        katakana_songs = Song.search_by_title_name_artist(katakana).search_by_cover(search_params[:cover_eq]).order(created_at: :desc)
        result_songs = (search_songs + hiragana_songs + katakana_songs).uniq
      else
        search_songs = Song.search_by_title_name_artist(key_words).order(created_at: :desc)
        hiragana_songs = Song.search_by_title_name_artist(hiragana).order(created_at: :desc)
        katakana_songs = Song.search_by_title_name_artist(katakana).order(created_at: :desc)
        result_songs = (search_songs + hiragana_songs + katakana_songs).uniq
      end
      artist_name_matches = result_songs.select { |song| key_words.any? { |kw| song.artist_name =~ /#{Regexp.escape(kw)}/i } }
      result_songs = (artist_name_matches + result_songs).uniq

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
      key_words = search_params[:search].split(/[\p{blank}\s]+/)
      hiragana = key_words.map { |word| word.tr('ァ-ン', 'ぁ-ん') }
      katakana = key_words.map { |word| word.tr('ぁ-ん', 'ァ-ン') }

      if search_params[:cover_eq].present?
        search_songs = Song.where(id: song_ids).search_by_title_name_artist(key_words).search_by_cover(search_params[:cover_eq]).order(created_at: :desc)
        hiragana_songs = Song.where(id: song_ids).search_by_title_name_artist(hiragana).search_by_cover(search_params[:cover_eq]).order(created_at: :desc)
        katakana_songs = Song.where(id: song_ids).search_by_title_name_artist(katakana).search_by_cover(search_params[:cover_eq]).order(created_at: :desc)
        result_songs = (search_songs + hiragana_songs + katakana_songs).uniq
      else
        search_songs = Song.where(id: song_ids).search_by_title_name_artist(key_words).order(created_at: :desc)
        hiragana_songs = Song.where(id: song_ids).search_by_title_name_artist(hiragana).order(created_at: :desc)
        katakana_songs = Song.where(id: song_ids).search_by_title_name_artist(katakana).order(created_at: :desc)
        result_songs = (search_songs + hiragana_songs + katakana_songs).uniq
      end
      artist_name_matches = result_songs.select { |song| key_words.any? { |kw| song.artist_name =~ /#{Regexp.escape(kw)}/i } }
      result_songs = (artist_name_matches + result_songs).uniq
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
    hiragana = params[:q].tr('ァ-ン', 'ぁ-ん')
    katakana = params[:q].tr('ぁ-ん', 'ァ-ン')

    search_names = Song.search_by_name(params[:q]).pluck(:name).flatten.uniq
    hiragana_names = Song.search_by_name(hiragana).pluck(:name).flatten.uniq
    katakana_names = Song.search_by_name(katakana).pluck(:name).flatten.uniq
    song_names = (search_names + hiragana_names + katakana_names).uniq

    search_artist_names = Song.search_by_artist(params[:q]).pluck(:artist_name).flatten.uniq
    hiragana_artist_names = Song.search_by_artist(hiragana).pluck(:artist_name).flatten.uniq
    katakana_artist_names = Song.search_by_artist(katakana).pluck(:artist_name).flatten.uniq
    song_artist_names = (search_artist_names + hiragana_artist_names + katakana_artist_names).uniq
    
    @results = (song_names + song_artist_names).uniq.take(20)
    respond_to do |format|
      format.js
    end
  end

  private

  def search_params
    params.permit(:search, :title, :name, :artist_name, :cover_eq, :cover)
  end
end
