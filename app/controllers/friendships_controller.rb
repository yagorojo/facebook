class FriendshipsController < ApplicationController
  def create
    @friend = User.find(params[:id])
    @friendship = Friendship.new(
      user: current_user, 
      friend: @friend, 
      accepted: false
    )

    if @friendship.save
      flash[:notice] = "Friend request sent."
    else
      flash[:error] = "Failed to send friend request."
    end

    redirect_to @friend
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update(accepted: true)
    Friendship.create(
      user: current_user, 
      friend: @friendship.user, 
      accepted: true
    )
  end

  def destroy 
    @friend = User.find(params[:id])
    @friendship = current_user.friendships.find_by(friend: @friend)
    @reciprocal_friendship = Friendship.find_by(friend: current_user, user: @friend)

    if @reciprocal_friendship
      @reciprocal_friendship.delete
    end

    if @friendship && @friendship.delete
      flash[:notice] = "Friend removed."
    end

    redirect_to @friend
  end
end