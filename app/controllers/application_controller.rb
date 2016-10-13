class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # モジュールをinclude
  include SessionsHelper
  
  def t(key, options={})
    if key[0] == '.'
      key = controller_name + "_controller." + action_name + key
    end
    super
  end
  
  private 
    def logged_in_user
      #ログインしていない
      unless logged_in?
        store_location
        flash[:danger] = t('application_controller.private.logged_in_user')
        redirect_to login_url
      end
    end
end
