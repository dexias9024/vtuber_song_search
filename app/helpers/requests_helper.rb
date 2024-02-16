module RequestsHelper
  def search_autocomplete(search_params)
    hiragana = search_params.tr('ァ-ン', 'ぁ-ん')
    katakana = search_params.tr('ぁ-ん', 'ァ-ン')

    search_names = Member.search_by_name(search_params).pluck(:name).flatten.uniq
    hiragana_names = Member.search_by_name(hiragana).pluck(:name).flatten.uniq
    katakana_names = Member.search_by_name(katakana).pluck(:name).flatten.uniq
    results = (search_names + hiragana_names + katakana_names).uniq.take(20)
  end
end
