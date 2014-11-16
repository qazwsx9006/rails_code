class SessionsController < ApplicationController
	before_filter :signed_out_user, only: [:new, :create]
	skip_before_filter :save_back_url

	def new
	end
	def create
		user = User.find_by_account(params[:user][:account].downcase)
		if user && user.authenticate(params[:user][:password]) 
			sign_in_session(user)
			redirect_to session[:return_to] || root_path
		elsif user
			@wrong=true
			render 'new'
		else
			@wrong=true
			render 'new'
		end
	end
	def destroy
		sign_out
		redirect_to session[:return_to] || root_path
	end

end
