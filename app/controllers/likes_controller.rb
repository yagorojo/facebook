class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.build(post: @post)

    if current_user.likes?(@post)
      redirect_to @post, alert: 'You already liked this post!'
    else
      if @like.save
        flash[:notice] = 'Post liked!'
      end
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy

    # respond_to do |format|
    #   format.turbo_stream { render turbo_stream: turbo_stream.update(@like, ) }
    # end
  end
end
