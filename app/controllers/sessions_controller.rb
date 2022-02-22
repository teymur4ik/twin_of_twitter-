class SessionsController < ApplicationController

  # присвоить текущей сессии ничего
  def new
    session[:user_id] = nil
  end

  # авторизация пользователя, если прошла, перенаправить на страницу постов, если нет, остаться на странице, выдать оповещение
  def create
    user = User.find_by(name: params[:name])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to posts_path
    else
      redirect_to login_path, notice: 'Invalid Username or Password'
    end
  end

  # выйти из сессии, перенаправить на страницу авторизации, выдать оповещение
  def destroy
    session[:users_id] = nil
    redirect_to login_path, notice: 'Successfully logged out'
  end
end
