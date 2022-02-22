class UsersController < ApplicationController
  # аналогично posts_controller.rb
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authorize, only: %i[show edit update destroy index]
  before_action :permit, only: %i[edit update destroy]
  
  def index
    @users = User.all
  end
  
  def show; end
  
  def new
    @user = User.new
  end
  
  def edit; end
  
  def create
    if User.find_by_name(user_params[:name])
      redirect_to new_user_path
    else
      @user = User.new(user_params)
      if @user.save
        redirect_to @user
      else
        redirect_to new_user_path
      end
    end
  end
  
  def update
    if @user.update(user_params)
      redirect_to @user
    else
      redirect_to edit_user_path, notice: 'Please check the information !'
    end
  end
  
  def destroy
    @user.destroy
    redirect_to login_path
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
  
  def permit
    return unless session[:user_id] != @user.id && session[:user_id] != 1

    redirect_to @user, notice: 'You trying to access without permit?'
  end
end
  
