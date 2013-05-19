class BaseController <  ActionController::Base


	private

	def check_session
		puts "session : #{session.inspect}"
		if session && params[:controller] == 'base' && params[:action] == 'index'
			puts "session : #{session.inspect}"
			# => TODO
			redirect_to user_dashboard_path(session[:id])
		end
	end
end