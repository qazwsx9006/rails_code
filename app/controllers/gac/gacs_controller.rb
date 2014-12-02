class Gac::GacsController < Gac::ApplicationController

	def show
		@gacs=Gac.all.includes(:actions)
	end

	def create
		gac=Gac.new(gac_params)
		if gac.save
			s=gac.actions.build
			s.name='漆彈'
			s.save
		else
		end
		redirect_to gac_path
	end


  private

  def gac_params
    params.require(:gac).permit(:name, :phone, :add,:age, :grade, :fone,:fb, :line, :other)
  end

end
