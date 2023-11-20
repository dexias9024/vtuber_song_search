class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = t('.success')
    else
      flash[:danger] = t('.fail')
    end
    redirect_to request.referer
  end

  def destroy
    @comment.destroy!
    flash[:success] = t('.success')
    redirect_to request.referer, status: :see_other
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content).merge(song_id: params[:song_id])
  end
end
