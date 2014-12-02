class Gac::ActionsController < Gac::ApplicationController

	def update
		act=Action.find_by_id(params[:id])
		act.join=params[:join].to_i
		if act.save
			render text: "#{params[:join]}__ok"
		else
			render text: "err"
		end
	end
end
