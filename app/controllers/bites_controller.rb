class BitesController < ApplicationController
	def index 
		
	end
	def create
		favorities = current_user.favorites.build(favority_params)
		if favorities.save
			redirect_to bite_path(current_user)
		else
			render text: favorities.errors.full_messages
		end
	end
	def show 
		@user=User.find_by_id(params[:id])
		@favorities=@user.favorites.order(created_at: :desc)
	end
	def askcoodinate
		#if params[:search].present?
		#	@favorities = Favorite.near(params[:search], 500, :order => :distance)#距離判斷遠近
		#else
			@favorities = Favorite.all
		#end

		render :json => @favorities.to_json
		
	end

  private

  def favority_params
    params.require(:favority).permit(:pic, :msg, :address)
  end
end
