class UsersController < BaseController
	before_filter :check_user
  layout "application"
  
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

  	def new
  		@roles = @user.get_roles
  	end

  	def create
  		@user.create_user(params[:name], params[:username], params[:email], params[:phone], params[:role], params[:password])
  		redirect_to user_admin_index_path(@user.id, {:message => "Uspjesno dodan korisnik #{params[:name]}" })
  	end

  	def destroy
  		@user.delete_user(params[:id])
  		redirect_to user_admin_index_path(@user.id, {:message => "Uspjesno izbrisan korisnik #{params[:name]}" })
  	end

  	def edit
  		@roles = @user.get_roles
  		@editing_user = User.find params[:id]
  	end

  	def update
  		@user.edit_user(params[:id], params[:name], params[:username], params[:email], params[:phone], params[:role], params[:password])
  		redirect_to user_admin_index_path(@user.id, {:message => "Uspjesno izmjenjen korisnik #{params[:name]}" })
  	end

  	def settings

  	end

  	def update_settings
  		if @user.password_valid?(params[:old_pass])
        @user.edit_self_user(params[:name], params[:username], params[:email], params[:phone], params[:new_pass])
        redirect_to user_settings_path(@user.id, {:message => 'Izmjena uspjesna'})
      else
        redirect_to user_settings_path(@user.id, {:message => 'Stara lozinka je neispravna'})
      end
  	end
  	private

  	def check_user
  		@user = User.find(session[:id]) if (@user.nil? && session[:id])
  	end
end