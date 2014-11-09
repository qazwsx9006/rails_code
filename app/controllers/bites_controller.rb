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
		if params[:id]
			if params[:id].to_i.abs==0
				if params[:c].blank?
					center = [25.0479,121.517]
				else
					center = params[:c]
				end
				if params[:d].blank?
					distance = 500
				else
					distance = params[:d]
				end
				@favorities=Favorite.near(center,distance)
			else
				@user=User.find_by_id(params[:id])
				@favorities=@user.favorites #.order(created_at: :desc)
			end
		else
			@favorities = Favorite.all
		end


		#if params[:search].present?
		#	@favorities = Favorite.near(params[:search], 500, :order => :distance)#距離判斷遠近
		#else
		#	@favorities = Favorite.all
		#end

		render :json => @favorities.to_json
		
	end

  private

  def favority_params
    params.require(:favority).permit(:pic, :msg, :address)
  end
end
