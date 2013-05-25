class User < ActiveRecord::Base
	attr_accessible :name, :email, :phone, :role, :username, :hash_code
	ROLE_ADMIN 	= 0
	ROLE_MAIN	= 1
	ROLE_BASIC	= 2

	has_many :payers

	# => User CRUD + stuff
	# => Create user (can only be invoked by User::ROLE_ADMIN)
	def create_user(name, username, email, phone, role, password)
		User.create({:name => name, :email => email, :phone => phone, :role => role, :username => username, :hash_code => Digest::SHA256.hexdigest(password)}) if self.is_admin?
	end

	def self.create_admin_user()
		User.create({:name => 'Admin', :email => 'pjanicedin87@gmail.com', :phone => '111111', :role => ROLE_ADMIN, :username => 'admin', :hash_code => Digest::SHA256.hexdigest('obveznici')})
	end
	
	def delete_user(user_id)
		User.destroy(user_id) if self.is_admin?
	end

	# => Administrator edit
	def edit_user(id, name, username, email, phone, role, password)
		user = User.find id
		user.name = name
		user.username = username
		user.email = email
		user.phone = phone
		user.role = role
		user.hash_code = Digest::SHA256.hexdigest(password) unless password.blank?
		user.save
	end
	
	# => User edits for it's self
	def edit_self_user(name, username, email, phone, password)
		self.name = name
		self.username = username
		self.email = email
		self.phone = phone
		self.hash_code = Digest::SHA256.hexdigest(password) unless password.blank?
		self.save
	end

	# => Payer CRUD
	def get_all_payers
		Payer.all
	end

	def create_payer(name, township_id, address, jmbg, pdv_payer, comment, phone)
		payer = Payer.new
		payer.subject_name = name
		payer.township_id = township_id
		payer.address = address
		payer.jmbg = jmbg
		payer.pdv_payer = pdv_payer
		payer.comment = comment
		payer.phone = phone
		payer.user_id = self.id
		payer.save
	end

	def delete_payer(payer_id)
		payer = Payer.find(payer_id)
		payer.destroy if(self.is_admin? || self.id == payer.user_id)
	end

	def edit_payer(payer_id, name, township_id, address, jmbg, pdv_payer, comment, phone)
		payer = Payer.find(payer_id)
		payer.subject_name = name
		payer.township_id = township_id
		payer.address = address
		payer.jmbg = jmbg
		payer.pdv_payer = pdv_payer
		payer.comment = comment
		payer.phone = phone
		payer.save
	end

	# => User checkers
	def is_admin?
		return self.role == ROLE_ADMIN
	end

	def is_viewer?
		return self.role == ROLE_BASIC
	end

	def password_valid?(old_pass)
		return Digest::SHA256.hexdigest(old_pass) == self.hash_code
	end
	# => User roles utils
	def stringify_role
		case self.role
			when ROLE_ADMIN then return 'Administrator'
			when ROLE_MAIN  then return 'Uredjivac'
			when ROLE_BASIC then return 'Pregledavac'
		end
	end

	def get_roles
		return [{:value => 0, :name => 'Administrator'}, {:value => 1, :name => 'Uredjivac'}, {:value => 2, :name => 'Pregledavac'}]
	end

	# => Search
	def search_payers(query_params)
		query = ""
		query += query_params[:township].blank? || query_params[:township] == 0 || query_params[:township] == "0" ?  "" : "township_id = #{query_params[:township]}"
		query += query_params[:subject_name].blank? ?  "" : ' AND subject_name ilike \'%' + query_params[:subject_name] + '%\''
		query += query_params[:address].blank? ?  "" : ' AND address ilike \'%' + query_params[:address] + '%\''
		query += query_params[:jmbg].blank? ?  "" : ' AND jmbg ilike \'%' + query_params[:jmbg] + '%\''
		query += query_params[:phone].blank? ?  "" : ' AND phone ilike \'%' + query_params[:phone] + '%\''
		query += query_params[:pdv_payer].blank? ?  "" : " AND pdv_payer = #{query_params[:pdv_payer] == 'on' ? true : false}"
		puts "--------------------------------------------------------------------------------------------"
		puts "#{query_params}"
		puts "--------------------------------------------------------------------------------------------"
		puts "#{query}"
		puts "--------------------------------------------------------------------------------------------"
		Payer.where(query)
	end

end