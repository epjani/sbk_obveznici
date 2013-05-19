class RemoveOrdinalAddPhoneToPayer < ActiveRecord::Migration
  def up
  	remove_column :payers, :ordinal
  	add_column :payers, :phone, :string
  	add_column :payers, :user_id, :integer
    add_column :payers, :created_at, :datetime
    add_column :payers, :updated_at, :datetime
  end

  def down
  	add_column :payers, :ordinal, :integer
  	remove_column :payers, :phone
  	remove_column :payers, :user_id
    remove_column :payers, :created_at
    remove_column :payers, :updated_at
  end
end
