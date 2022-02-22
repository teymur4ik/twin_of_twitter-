class PostsController < ApplicationController
    # перенаправление на авторизацию, файл: application_controller.rb
    before_action :authorize
    # сначала использовать метод index, потом использовать метод set post для приведенных методов, аналогично с permit
    skip_before_action :authorize, only: :index
    before_action :set_post, only: %i[show edit update destroy]
    before_action :permit, only: %i[edit update destroy]

    # сделать массив из класса Post
    def index
      @posts = Post.all
    end
  
    def show; end

    # создать новый пост
    def new
      @post = Post.new
    end

    # проверить, сохранился ли пост, если да, перенаправить на него, если нет, остаться на странице создания поста
    def create
      @post = Post.new(user_id: session[:user_id], title: post_params[:title], body: post_params[:body])
      if @post.save
        redirect_to @post
      else
        render 'new'
      end
    end

    # проверить, обновился ли пост, если да, перенаправить на него, если нет, остаться на странице создания поста
    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to @post
      else
        render 'edit'
      end
    end
  
    def edit; end

    # удалить пост
    def destroy
      @post.destroy
  
      redirect_to posts_path
    end
  
    private

    # проверить, являетсся ли пользователь зарегистрированным, если нет, выдать оповещение
    def permit
      return unless session[:user_id] != @user.id && session[:user_id] != 1
  
      redirect_to @post, notice: 'You trying to access without permit?'
    end

    # найти пост, найти пользователя, создавшего пост, найти текущую сессию
    def set_post
      @post = Post.find(params[:id])
      @user = User.find_by_id(@post.user_id)
      @user_session = User.find_by_id(session[:user_id]).name
    end

    # выдать доступ к оглавлению и тексту body
    def post_params
      params.require(:post).permit(:title, :body)
    end
  end
  
