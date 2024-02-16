module SongsHelper
  def search_songsname_cover(search_params)
    key_words = search_params[:search].split(/[\p{blank}\s]+/)
    hiragana = key_words.map { |word| word.tr('ァ-ン', 'ぁ-ん') }
    katakana = key_words.map { |word| word.tr('ぁ-ん', 'ァ-ン') }
  
    search_songs = Song.search_by_title_name_artist(key_words).search_by_cover(search_params[:cover_eq]).order(created_at: :desc)
    hiragana_songs = Song.search_by_title_name_artist(hiragana).search_by_cover(search_params[:cover_eq]).order(created_at: :desc)
    katakana_songs = Song.search_by_title_name_artist(katakana).search_by_cover(search_params[:cover_eq]).order(created_at: :desc)
  
    result_songs = (search_songs + hiragana_songs + katakana_songs).uniq
  
    artist_name_matches = result_songs.select { |song| key_words.any? { |kw| song.artist_name =~ /#{Regexp.escape(kw)}/i } }
    (artist_name_matches + result_songs).uniq
  end

  def search_songsname(search_params)
    key_words = search_params[:search].split(/[\p{blank}\s]+/)
    hiragana = key_words.map { |word| word.tr('ァ-ン', 'ぁ-ん') }
    katakana = key_words.map { |word| word.tr('ぁ-ん', 'ァ-ン') }
  
    search_songs = Song.search_by_title_name_artist(key_words).order(created_at: :desc)
    hiragana_songs = Song.search_by_title_name_artist(hiragana).order(created_at: :desc)
    katakana_songs = Song.search_by_title_name_artist(katakana).order(created_at: :desc)
  
    result_songs = (search_songs + hiragana_songs + katakana_songs).uniq
  
    artist_name_matches = result_songs.select { |song| key_words.any? { |kw| song.artist_name =~ /#{Regexp.escape(kw)}/i } }
    (artist_name_matches + result_songs).uniq
  end
  
  def favorite_search_songsname_cover(search_params)
    key_words = search_params[:search].split(/[\p{blank}\s]+/)
    hiragana = key_words.map { |word| word.tr('ァ-ン', 'ぁ-ん') }
    katakana = key_words.map { |word| word.tr('ぁ-ん', 'ァ-ン') }
  
    search_songs = Song.where(id: song_ids).search_by_title_name_artist(key_words).search_by_cover(search_params[:cover_eq]).order(created_at: :desc)
    hiragana_songs = Song.where(id: song_ids).search_by_title_name_artist(hiragana).search_by_cover(search_params[:cover_eq]).order(created_at: :desc)
    katakana_songs = Song.where(id: song_ids).search_by_title_name_artist(katakana).search_by_cover(search_params[:cover_eq]).order(created_at: :desc)
  
    result_songs = (search_songs + hiragana_songs + katakana_songs).uniq
  
    artist_name_matches = result_songs.select { |song| key_words.any? { |kw| song.artist_name =~ /#{Regexp.escape(kw)}/i } }
    (artist_name_matches + result_songs).uniq
  end

  def favorite_search_songsname(search_params)
    key_words = search_params[:search].split(/[\p{blank}\s]+/)
    hiragana = key_words.map { |word| word.tr('ァ-ン', 'ぁ-ん') }
    katakana = key_words.map { |word| word.tr('ぁ-ん', 'ァ-ン') }
  
    search_songs = Song.where(id: song_ids).search_by_title_name_artist(key_words).order(created_at: :desc)
    hiragana_songs = Song.where(id: song_ids).search_by_title_name_artist(hiragana).order(created_at: :desc)
    katakana_songs = Song.where(id: song_ids).search_by_title_name_artist(katakana).order(created_at: :desc)
  
    result_songs = (search_songs + hiragana_songs + katakana_songs).uniq
  
    artist_name_matches = result_songs.select { |song| key_words.any? { |kw| song.artist_name =~ /#{Regexp.escape(kw)}/i } }
    (artist_name_matches + result_songs).uniq
  end

  def search_autocomplete(search_params)
    hiragana = search_params.tr('ァ-ン', 'ぁ-ん')
    katakana = search_params.tr('ぁ-ん', 'ァ-ン')

    search_names = Song.search_by_name(search_params).pluck(:name).flatten.uniq
    hiragana_names = Song.search_by_name(hiragana).pluck(:name).flatten.uniq
    katakana_names = Song.search_by_name(katakana).pluck(:name).flatten.uniq
    song_names = (search_names + hiragana_names + katakana_names).uniq

    search_artist_names = Song.search_by_artist(search_params).pluck(:artist_name).flatten.uniq
    hiragana_artist_names = Song.search_by_artist(hiragana).pluck(:artist_name).flatten.uniq
    katakana_artist_names = Song.search_by_artist(katakana).pluck(:artist_name).flatten.uniq
    song_artist_names = (search_artist_names + hiragana_artist_names + katakana_artist_names).uniq
    result = (song_names + song_artist_names).uniq.take(20)
  end
end
