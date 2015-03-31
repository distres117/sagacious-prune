class Course < ActiveRecord::Base
  belongs_to :user
  has_many :assignment_types, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :homeworks
  has_many :quizzes
  has_many :tests
  has_many :notes, as: :notable

  def get_total
  	self.assignment_types.map(&:percentage).sum
  end

  def filtered_types
  	self.assignment_types.reject {|a| a.assign_type == "Participation"}
  end

  def get_final_grade(student)
    grades =[]
    assignment_types.each do |atype|
      par = (atype.percentage * 100) / assignments.where(assign_type: atype.assign_type).count
      grades << student.grades_by_type(atype.assign_type).inject(0) {|acc, i| acc += i.score * par }
 
  end
  return grades.sum
end


end

