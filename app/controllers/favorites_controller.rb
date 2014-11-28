class FavoritesController < ApplicationController
	skip_before_filter :save_back_url, only: [:comment,:like,:unlike]
	def show
		@favorite=Favorite.find_by_id(params[:id])
		@user=User.find_by_id(@favorite.user_id)
		@comments = @favorite.comments.includes(:users).offset(0).limit(10)
		@likes=@favorite.likes.includes(:users)
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
	def more_comment
		@favorite=Favorite.find_by_id(params[:id])
		@comments = @favorite.comments.includes(:users).offset(params[:next].to_i).limit(10)

		render 'more_comment',layout: false
	end

	def like
		favorite=Favorite.find_by_id(params[:id])
		unless favorite.like?(current_user)
			favorite.like(current_user)
			user=favorite.users
			user.heart_sum+=1
			user.save(validate: false)
		end
		redirect_to session[:return_to] || favorite_path(params[:id]) || root_path
	end
	def unlike
		favorite=Favorite.find_by_id(params[:id])
		if favorite.like?(current_user)
			favorite.unlike(current_user)
			user=favorite.users
			user.heart_sum-=1
			user.save(validate: false)
		end
		redirect_to session[:return_to] || favorite_path(params[:id]) || root_path
	end
end
