class SessionsController < ApplicationController
	before_filter :signed_out_user, only: [:new, :create]

	def new
	end
	def create
		user = User.find_by_account(params[:user][:account].downcase)
		if user && user.authenticate(params[:user][:password]) 
			sign_in_session(user)
			redirect_to root_path
		elsif user
			render text: "oops:password wrong"
		else
			render text: "oops:no this account!"
		end
	end
	def destroy
		sign_out
		redirect_to root_path
	end

end
