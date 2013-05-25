class CreateTablePayers < ActiveRecord::Migration
  def up
  	create_table :payers do |p|
  		p.integer 		:ordinal
  		p.string		:subject_name
  		p.references	:township
  		p.string		:address
  		p.string		:jmbg
  		p.boolean		:pdv_payer
  		p.text			:comment

      p.timestamp
  	end
  end

  def down
  	drop_table :payers
  end
end
