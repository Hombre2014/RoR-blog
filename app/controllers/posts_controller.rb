class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:notice] = 'The post have been created successfully.'
      redirect_to "#{users_path}/#{current_user.id}"
    else
      flash[:alert] = 'Adding a new post failed.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @author = @post.author
    @author.posts_counter -= 1
    @post.destroy!
    redirect_to user_posts_path(id: @author.id), notice: 'The post have been deleted successfully!'
  end

  private

  def post_params
    params.require(:post).permit(:author_id, :title, :text)
  end
end
