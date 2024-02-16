module Admin::CommentsHelper
  def search_comments(search_params)
    hiragana = search_params.tr('ァ-ン', 'ぁ-ん')
    katakana = search_params.tr('ぁ-ん', 'ァ-ン')

    search_comments = Comment.search_comments(search_params).order(created_at: :desc)
    hiragana_comments = Comment.search_comments(hiragana).order(created_at: :desc)
    katakana_comments = Comment.search_comments(katakana).order(created_at: :desc)
    result_comments = (search_comments + hiragana_comments + katakana_comments).uniq
    comments = Kaminari.paginate_array(result_comments).page(params[:page]).per(20)
  end
end
