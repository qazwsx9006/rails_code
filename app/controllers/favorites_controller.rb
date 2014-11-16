class FavoritesController < ApplicationController
	skip_before_filter :save_back_url, only: [:comment]
	def show
		@favorite=Favorite.find_by_id(params[:id])
		@user=User.find_by_id(@favorite.user_id)
		@comments = @favorite.comments.includes(:users)
	end

	def comment
		@comments=current_user.comments.new
		@comments.msg=params[:msg]
		@comments.favority_id=params[:id]

		if @comments.save
		else
		end
		redirect_to favorite_path(params[:id])
	end
end
