class DashboardsController < ApplicationController
	def index
		@payers = @user.get_all_payers
	end
end