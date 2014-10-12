class UsersController < ApplicationController
	
	def index 
	end

	def new
		render 'new', layout: 'signup'
	end
	def create
		@user=User.new(user_params)
		if @user.save
			render 'show'
		else
			render text: "oops: #{@user.errors.full_messages}"
		end
	end

	def show 
		@user=User.find_by_id(params[:id])
	end

  private

  def user_params
    params.require(:user).permit(:nickname, :password, :password_confirmation,:account)
  end
end
