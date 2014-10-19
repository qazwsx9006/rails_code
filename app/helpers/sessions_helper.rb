module SessionsHelper
		
	#基本會員登入登出功能	
	def sign_in_session(user)
		session[:mimi_t] = user.mimi_t 
		self.current_user = user
	end
	def sign_in_cookies(user)
		cookies.permanent[:mimi_t] = user.mimi_t 
		self.current_user = user
	end
	def signed_in?
		!current_user.nil?
	end

	def signed_in_user
      #redirect_to signin_path, notice: "Please sign in." unless signed_in?
      unless signed_in?
        #store_location
        redirect_to signin_path#, notice: "Please sign in."
      end
	end

	def signed_out_user
      if signed_in?
        redirect_to root_path
      end
	end

	def sign_out(update=true)
		member=User.find_by_mimi_t(self.current_user.mimi_t)
		if update
			member.update_attribute('mimi_t',SecureRandom.urlsafe_base64())
		end

		self.current_user = nil
		session.delete(:mimi_t)
		cookies.delete(:mimi_t)
	end

	def current_user=(user)
		@current_user = user
	end
	def current_user
		if !cookies[:mimi_t].blank?
			@current_user = @current_user || User.find_by_mimi_t(cookies[:mimi_t]) 
		else 
			@current_user = @current_user || User.find_by_mimi_t(session[:mimi_t]) 
		end
		return @current_user
	end

end
