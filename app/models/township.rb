class Township < ActiveRecord::Base
	attr_accessible :name
	has_many :payers

	def self.insert_township(name)
		Township.create({:name => name})
	end
end