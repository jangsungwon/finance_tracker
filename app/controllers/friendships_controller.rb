class FriendshipsController < ApplicationController

  def destroy
    friendship = Friendship.where(user_id: current_user.id, friend_id: params[:id]).first
    byebug
    friendship.destroy
    flash[:notice] = "#{User.find(params[:id]).full_name} was successfully removed from friends list"
    redirect_to friends_path
  end

end
