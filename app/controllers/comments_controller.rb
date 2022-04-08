class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @post = Post.find(comment_params[:post_id])

    if @comment.save
      redirect_to user_post_path @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :text)
  end
end
