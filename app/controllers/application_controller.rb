class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception # Это включит токен безопасности во все формы и запросы Ajax, генерируемые Rails.
    before_action :set_locale # прежде чем переходить к любому методу, будет выполнен set_locale
  
    protected # методы могут использоваться в этом классе или классе потомке

    # проверяет, авторизован ли пользователь
    def authorize
      return if User.find_by(id: session[:user_id])
  
      redirect_to '/login', notice: 'You trying to access without permit?'
    end

    # устанавливает язык
    def set_locale
      I18n.locale = params[:locale] if params[:locale].present?
    end

    # добавить язык ко всем URL-адресам, генерируемым приложением
    def default_url_options(options = {})
      options.merge(locale: I18n.locale)
    end
  end