class Gac::ActionsController < Gac::ApplicationController

	def update
		act=Action.find_by_id(params[:id])
		act.play=params[:play].to_i
		if act.save
			render text: "#{params[:play]}__ok"
		else
			render text: "err"
		end
	end
end
