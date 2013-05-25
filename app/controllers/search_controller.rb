class SearchController < ApplicationController
	def index
		@townships = Township.all
		if query_empty?
			@payers = Payer.all
		else
			@payers = @user.search_payers(params)
		end
	end

	private

	def query_empty?
		return params[:subject_name].blank? && (params[:township].blank? || params[:township] == 0) && params[:address].blank? && params[:phone].blank? && params[:jmbg].blank? && params[:pdv_payer].blank? ? true : false
	end
end