class User < ActiveRecord::Base
	attr_accessible :name, :email, :phone, :role, :username, :hash_code
	ROLE_ADMIN 	= 0
	ROLE_MAIN	= 1
	ROLE_BASIC	= 2

	has_many :payers

	# => Create user (can only be invoked by User::ROLE_ADMIN)
	def create_user(name, email, phone, username, password, role)
		if(self.role == ROLE_ADMIN)
			hashed_pass = Digest::SHA256.hexdigest(password)
			User.create({:name => name, :email => email, :phone => phone, :role => role, :username => username, :hash_code => hashed_pass})
		end
	end

	def self.create_admin_user()
		User.create({:name => 'Admin', :email => 'pjanicedin87@gmail.com', :phone => '111111', :role => ROLE_ADMIN, :username => 'admin', :hash_code => Digest::SHA256.hexdigest('obveznici')})
	end

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
end