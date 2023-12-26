class Admin::CommentsController < Admin::BaseController
  def index
    @q = Comment.ransack(params[:q])
    @comments = @q.result.includes(:song).order(created_at: :desc).page(params[:page])
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

  def comment_params
    params.require(:comment).permit(:content).merge(song_id: params[:song_id])
  end
end
