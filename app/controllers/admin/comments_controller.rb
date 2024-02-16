class Admin::CommentsController < Admin::BaseController
  include Admin::CommentsHelper
  def index
    @comments = if search_params[:search].present?
                  search_comments(search_params[:search])
                else
                  Comment.all.order(created_at: :desc).page(params[:page])
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
