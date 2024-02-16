module Admin::VtubersHelper
  def search_vtubers(search_params)
    key_words = search_params.split(/[\p{blank}\s]+/)
    hiragana = key_words.map { |word| word.tr('ァ-ン', 'ぁ-ん') }
    katakana = key_words.map { |word| word.tr('ぁ-ん', 'ァ-ン') }

    search_vtubers = Vtuber.search_by_name_channel_name(key_words).order(created_at: :desc)
    hiragana_vtubers = Vtuber.search_by_name_channel_name(hiragana).order(created_at: :desc)
    katakana_vtubers = Vtuber.search_by_name_channel_name(katakana).order(created_at: :desc)
    result_vtubers = (search_vtubers + hiragana_vtubers + katakana_vtubers).uniq
    vtubers = Kaminari.paginate_array(result_vtubers).page(params[:page]).per(20)
  end
end
