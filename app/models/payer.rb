class Payer < ActiveRecord::Base
	belongs_to :township
	belongs_to :user
	
	def pdv_payer?
		return self.pdv_payer ? 'Da' : 'Ne'
	end
end