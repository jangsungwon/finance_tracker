class UsersController < ApplicationController
  before_action :authenticate_portfolio, only: [:portfolio]

  def portfolio
    user = User.find(params[:id])
    @tracked_stocks = user.stocks
  end

  def friends
    @friends = current_user.friends
  end

  def search
    render json: params[:friend]
  end

  private

  def authenticate_portfolio
    if params[:id].to_i != current_user.id && !current_user.friends.ids.include?(params[:id].to_i)
      flash[:alert] = "You are not allowed to access"
      redirect_to root_path
    end
  end

end
