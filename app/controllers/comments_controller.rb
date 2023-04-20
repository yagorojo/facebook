class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('comments', @comment) }
      else
        format.html { redirect_to @post, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if current_user.id == @comment.user_id && @comment.destroy
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
      else
        format.html { redirect_to messages_url, status: :unprocessable_entity }
      end
    end
  end

  # def destroy
  #   @comment = Comment.find(params[:id])

  #   respond_to do |format|
  #     if current_user.id == @comment.user_id && @post.destroy
  #       format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
  #     else
  #       format.html { redirect_to messages_url, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end
end