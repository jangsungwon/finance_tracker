class FriendshipsController < ApplicationController

  def create
    friend = User.find(params[:id])
    current_user.friends << friend
    # current_user.friendships.build(friend_id: friend.id)
    # current_user.save
    flash[:notice] = "#{friend.full_name} was successfully added to friends list"
    redirect_to friends_path
  end

  def destroy
    friendship = Friendship.where(user_id: current_user.id, friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "#{User.find(params[:id]).full_name} was successfully removed from friends list"
    redirect_to friends_path
  end

end
