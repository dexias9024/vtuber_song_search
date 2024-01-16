class Admin::CommentsController < Admin::BaseController
  def index
    if search_params[:search].present?
      hiragana = search_params[:search].tr('ァ-ン', 'ぁ-ん')
      katakana = search_params[:search].tr('ぁ-ん', 'ァ-ン')

      hiragana_comments = Comment.search_comments(hiragana).order(created_at: :desc)
      katakana_comments = Comment.search_comments(katakana).order(created_at: :desc)
      result_comments = (hiragana_comments + katakana_comments).uniq
      @comments = Kaminari.paginate_array(result_comments).page(params[:page]).per(20)
    else
      @comments = Comment.all.order(created_at: :desc).page(params[:page])
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    if @comment
      @comment.destroy!
      flash[:success] = t('.success')
      redirect_to admin_comments_path
    else
      flash[:alert] = t('.fail')
      redirect_to admin_comments_path
    end
  end

  private

  def search_params
    params.permit(:search, { user: [:name] }, { song: [:title] })
  end
end
