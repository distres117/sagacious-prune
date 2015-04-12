class AssignmentType < ActiveRecord::Base
	belongs_to :course
	validates :assign_type, presence: true
	validates :percentage, presence: true
	validates_uniqueness_of :assign_type, scope: :course_id, case_sensitive: false
	before_save do
		self.assign_type = self.assign_type.titleize
	end
	
end
