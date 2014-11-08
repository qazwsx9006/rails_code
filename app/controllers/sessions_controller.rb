class SessionsController < ApplicationController
	before_filter :signed_out_user, only: [:new, :create]

	def new
	end
	def create
		user = User.find_by_account(params[:user][:account].downcase)
		if user && user.authenticate(params[:user][:password]) 
			sign_in_session(user)
			redirect_to bite_path(current_user)
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
		redirect_to root_path
	end

end
