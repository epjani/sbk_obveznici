class CreateTableOpstine < ActiveRecord::Migration
  def up
  	create_table :townships do |o|
  		o.string :name
  	end
  end

  def down
  	drop_table :townships
  end
end
