module Admin::UsersHelper
  def search_users(search_params)
    hiragana = search_params.tr('ァ-ン', 'ぁ-ん')
    katakana = search_params.tr('ぁ-ん', 'ァ-ン')

    search_users = User.search_by_name(search_params).order(created_at: :desc)
    hiragana_users = User.search_by_name(hiragana).order(created_at: :desc)
    katakana_users = User.search_by_name(katakana).order(created_at: :desc)
    result_users = (search_users + hiragana_users + katakana_users).uniq
    users = Kaminari.paginate_array(result_users).page(params[:page]).per(20)
  end
end
