class UsersController < ApplicationController
  before_action :authenticate_portfolio, only: [:portfolio]

  def portfolio
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js { render partial: 'users/friend_result' }
      end
    end
  end

  private

  def authenticate_portfolio
    if (params[:id].to_i != current_user.id && !current_user.friends.ids.include?(params[:id].to_i))
      flash[:alert] = "You are not allowed to access"
      redirect_to root_path
    end
  end

end
