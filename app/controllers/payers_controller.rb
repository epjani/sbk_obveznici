class PayersController < ApplicationController
	
	def new
		@townships = Township.all
	end

	def create
		@user.create_payer(params[:subject_name], params[:township], params[:address], params[:jmbg], params[:pdv_payer], params[:comment], params[:phone])
		redirect_to user_dashboard_path(@user.id)
	end

end