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
  	self.assignment_types.map(&:percentage).sum.round(2)
  end

  def filtered_types
  	self.assignment_types.reject {|a| a.assign_type == "Participation"}
  end

  def get_final_grade(student)
    grades =[]
    assignment_types.each do |atype|
      if !atype.drop_lowest
        par = (atype.percentage * 100) / assignments.where(assign_type: atype.assign_type).count
        grades << student.grades_by_type(atype.assign_type).inject(0) {|acc, i| acc += i.score * par }
      else
        par = (atype.percentage * 100) / (assignments.where(assign_type: atype.assign_type).count - 1)
        _grades = student.grades_by_type(atype.assign_type).sort_by(&:score)
        grades << _grades.drop(1).inject(0) {|acc, i| acc += i.score * par }
      end
 
  end
  return grades.sum
end


end

