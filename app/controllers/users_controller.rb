class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:settings, :update, :avatar] #登入才能造訪自己的設定頁面
	before_filter :signed_out_user, only: [:new, :create] #非登入才能註冊帳號
	skip_before_filter :save_back_url, only: [:follow,:unfollow]

	def index 
	end

	def new
		render 'new', layout: 'signup'
	end
	def create
		@user=User.new(user_params)
		if @user.save
			redirect_to bite_path(@user)
		else
			render text: "oops: 你的帳號密碼格式錯誤喔！！！這頁還沒做。請回上ㄧ頁:))"
		end
	end

	def settings 
		@user=current_user#尚未加入登入功能
	end
	def update
		@user=current_user
		@user.nickname=params[:user][:nickname]
		@user.mood=params[:user][:mood]
		@user.about=params[:user][:about]
		if @user.save(validate: false)
			#資料更新成功
		else
			#資料更新失敗
		end

		if params[:change_pw] && !params[:change_pw].values.join().blank? && @user.authenticate(params[:change_pw][:oldpw])
			#修改密碼
			if params[:change_pw][:oldpw] == params[:change_pw][:password]
				#新密碼與舊密碼相同不與更新！
			elsif @user.update_attributes(user_params_change_pw)
				#密碼更新成功
			else
				#密碼更新失敗
			end
		elsif !params[:change_pw].values.join().blank? && !@user.authenticate(params[:change_pw][:oldpw])
			#舊密碼輸入錯誤
		end
		redirect_to settings_path
	end
	def avatar
		current_user.avatar=params[:user][:avatar] 
		current_user.save(validate: false)
		
		redirect_to settings_path
	end
	def follow
		@user=current_user
		@followed_user = User.find_by_id(params[:id])
	    unless @user.following?(@followed_user)
	      flash[:error] = '加入特别关注失败' unless @user.follow(@followed_user)
	    end
    	redirect_to session[:return_to] || bite_path(params[:id]) || root_path
	end
	def unfollow
	    @user=current_user
	    @followed_user =  User.find_by_id(params[:id])
	    if @user.following?(@followed_user)
	      flash[:error] = '取消特别关注失败' unless @user.unfollow(@followed_user)
	    end
		redirect_to session[:return_to] || bite_path(params[:id]) || root_path
	end

  private

  def user_params
    params.require(:user).permit(:nickname, :password, :password_confirmation,:account,:mood,:about)
  end
  def user_params_change_pw
  	params.require(:change_pw).permit(:password, :password_confirmation)
  end
end
