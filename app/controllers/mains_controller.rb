class MainsController < ApplicationController
	def index 
		render 'index', layout: 'index'
	end
end
