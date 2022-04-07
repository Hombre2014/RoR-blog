class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to "#{users_path}/#{current_user.id}/posts/#{post.id}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:author_id, :post_id, :text)
    end
end
