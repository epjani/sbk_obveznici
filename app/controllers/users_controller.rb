class UsersController < BaseController
	
	def index
	end

	def login
		user = User.find_by_username_and_hash_code(params[:username], Digest::SHA256.hexdigest(params[:password]))
		if user
			session[:id] = user.id
			redirect_to user_dashboard_path(user.id)
		else
			redirect_to root_url({:error => 'Wrong username or password'})
		end
	end

	def logout
    	reset_session
    	session = nil
    	redirect_to root_url()
  	end
end