class ApplicationController < ActionController::Base
  include SessionsHelper #登入登出功能使用
  before_filter :save_back_url
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  private
  
    def save_back_url
      if request.get?
      	session[:return_to]=request.path || root_path
      end
    end

end
