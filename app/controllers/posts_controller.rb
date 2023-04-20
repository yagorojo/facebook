class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.order("created_at DESC")
  end
  
  def show
    @post = Post.includes(:comments, :likes).find(params[:id])
    @comment = Comment.new()
  end

  def new
    @post = Post.new
  end


  def create
    @post = current_user.posts.new(params.require(:post).permit(:body))

    respond_to do |format|
      if @post.save
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('posts', @post) }
      else
        format.html { redirect_to root_path, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @post = Post.find(params[:id])

    respond_to do |format|
      if current_user.id == @post.user_id && @post.destroy
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@post) }
      else
        format.html { redirect_to messages_url, status: :unprocessable_entity }
      end
    end
  end
end
