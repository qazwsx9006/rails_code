class BitesController < ApplicationController
	def index 
		
	end
	def create
		favorities = current_user.favorites.build(favority_params)
		if favorities.save
			render text: 'success'
		else
			render text: favorities.errors.full_messages
		end
	end
	def show 
		@user=User.find_by_id(params[:id])
		@favorities=@user.favorites.order(created_at: :desc)
	end

  private

  def favority_params
    params.require(:favority).permit(:pic, :msg)
  end
end
