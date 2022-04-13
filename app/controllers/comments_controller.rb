class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @post = Post.find(comment_params[:post_id])

    if @comment.save
      flash[:notice] = 'Comment has been created successfully'
      redirect_to user_post_path @post, notice: 'The comment have been created successfully.'
    else
      flash[:alert] = 'Adding a comment failed.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @post.comments_counter -= 1
    @comment.destroy!
    redirect_to user_post_path(id: @post.id), notice: 'The comment have been deleted successfully!'
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :text)
  end
end
