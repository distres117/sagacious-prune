class AssignmentType < ActiveRecord::Base
	belongs_to :course
	validates :assign_type, presence: true, uniqueness: true
	validates :percentage, presence: true
	before_save do
		self.assign_type = self.assign_type.titleize
	end
	
end
