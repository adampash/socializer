class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:logged_in]
  before_filter :correct_user?, :except => [:index, :logged_in]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def logged_in
    render json: {logged_in: user_signed_in? || false}
  end

end
