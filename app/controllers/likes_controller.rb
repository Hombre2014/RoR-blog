class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    @post = Post.find(like_params[:post_id])

    if @like.save
      flash[:notice] = "Like successfully created"
      redirect_to user_post_path(@post)
    else
      flash[:notice] = "Adding a like failed"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def like_params
    params.require(:like).permit(:author_id, :post_id)
  end
end
