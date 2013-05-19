class CreateTableUsers < ActiveRecord::Migration
  def up
  	create_table :users do |u|
  		u.string 	:name
  		u.string	:username
  		u.string	:email
  		u.string	:phone
  		u.integer	:role
  		u.string	:hash_code
  	end
  end

  def down
  	drop_table	:users
  end
end
