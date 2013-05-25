class PayersController < ApplicationController
	
	def new
		@townships = Township.all
	end

	def create
		@user.create_payer(params[:subject_name], params[:township], params[:address], params[:jmbg], params[:pdv_payer], params[:comment], params[:phone])
		redirect_to user_dashboard_path(@user.id)
	end

	def destroy
		@user.delete_payer(params[:id])
		redirect_to user_dashboard_path(@user.id, {:message => 'Korisnik uspjesno obrisan'})
	end

	def edit
		@townships = Township.all
		@payer = Payer.find(params[:id])
	end

	def update
		@user.edit_payer(params[:id], params[:subject_name], params[:township], params[:address], params[:jmbg], params[:pdv_payer], params[:comment], params[:phone])
		redirect_to user_dashboard_path(@user.id, {:message => 'Korisnik uspjesno izmjenjen'})
	end
end