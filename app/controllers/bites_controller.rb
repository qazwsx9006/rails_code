class BitesController < ApplicationController
	skip_before_filter :save_back_url, only: [:create, :askcoodinate]
	def index 
		@users=User.all.limit(10)
		# if params[:c].blank?
		# 	if Geocoder.search(request.ip).last.city.blank?
		# 		center = session[:location]  || '臺北'
		# 	else
		# 		center = session[:location] || request.ip || '臺北'
		# 	end
		# 	#center = session[:location] || request.ip || '臺北'
		# else
		# 	center = params[:c] 
		# end
		# distance = params[:d].blank? ? 500 : params[:d]
		#@favorites=Favorite.includes(:likes).near(center,distance).limit(10)
		#@favorites=Favorite.where("pic_file_name IS NOT NULL").includes(:likes).near(center,distance).limit(10)
		#session[:index_facorites]=@favorites.map(&:id)
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
		if params[:near]=='1'
			#center= params[:location] || request.ip 
			if Geocoder.search(request.ip).last.city.blank?
				center = session[:location]  || '臺北'
			else
				center = session[:location] || request.ip || '臺北'
			end
			#@favorities=@user.favorites.includes(:likes).includes(:comments).near(center).offset(params[:from].to_i || 0).limit(10)
			@favorities=@user.favorites.includes(:likes).near(center).offset(params[:from].to_i || 0).limit(10)
			#u.favorites.includes(:likes).near('taipei').offset(0).limit(10)
		else
			#@favorities=@user.favorites.includes(:likes).includes(:comments).order(created_at: :desc).offset(params[:from].to_i || 0).limit(10)
			@favorities=@user.favorites.includes(:likes).order(created_at: :desc).offset(params[:from].to_i || 0).limit(10)
		end
	end
	def more_favorites
		@user=User.find_by_id(params[:id])
		if params[:near]=='1'
			#center= params[:location] || request.ip 
			if Geocoder.search(request.ip).last.city.blank?
				center = session[:location]  || '臺北'
			else
				center = session[:location] || request.ip || '臺北'
			end
			#@favorities=@user.favorites.includes(:likes).includes(:comments).near(center).offset(params[:from].to_i || 0).limit(10)
			@favorities=@user.favorites.includes(:likes).near(center).offset(params[:from].to_i || 0).limit(10)
			#u.favorites.includes(:likes).near('taipei').offset(0).limit(10)
		else
			#@favorities=@user.favorites.includes(:likes).includes(:comments).order(created_at: :desc).offset(params[:from].to_i || 0).limit(10)
			@favorities=@user.favorites.includes(:likes).order(created_at: :desc).offset(params[:from].to_i || 0).limit(10)
		end
		render json: {
		  'json' => @favorities.as_json,
		    'html' => render_to_string(partial: 'more_favorites.html.erb')
		}
		#render 'more_favorites',layout: false
	end
	def askcoodinate
		if !params[:inilat].blank? && !params[:inilnt].blank?
			session[:location]=[params[:inilat].to_f,params[:inilnt].to_f]
		end
		if params[:id]
			if params[:id].to_i.abs==0
				#首頁
				if params[:c].blank?
					#if Geocoder.search(request.ip).last.city.blank?
						center = session[:location] || '臺北'
					#else
					#	center = session[:location] || request.ip || '臺北'
					#end
					#center = session[:location] || request.ip || '臺北'
				else
					center = params[:c] 
				end
				distance = params[:d].blank? ? 500 : params[:d]
				@favorites=Favorite.where("pic_file_name IS NOT NULL").includes(:likes).near(center,distance).limit(10)
				render json: {
				  	'json' => @favorites.as_json,
				    'html' => render_to_string(partial: 'index_favorites.html.erb'),
				    'text' => params.as_json,
				    'session' => session.as_json
				}
				return
			else
				#個人頁
				@user=User.find_by_id(params[:id])
				if params[:near]=='1'
					#center= params[:location] || request.ip 
					#if Geocoder.search(request.ip).last.city.blank?
						center = session[:location]  || '臺北'
					#else
					#	center = session[:location] || request.ip || '臺北'
					#end	
					@favorities=@user.favorites.near(center).offset(params[:from].to_i || 0).limit(10)
				else
					@favorities=@user.favorites.order(created_at: :desc).offset(params[:from].to_i || 0).limit(10)
				end

				#@favorities=@user.favorites #.order(created_at: :desc)
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
