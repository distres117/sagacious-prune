class Student < ActiveRecord::Base
  belongs_to :course
  has_many :assignments, through: :course
  has_many :homeworks, through: :course
  has_many :quizzes, through: :course
  has_many :tests, through: :course
  has_many :grades, dependent: :destroy
  has_many :notes, as: :notable
  validates :first, presence: true
  validates :last, presence: true
  before_save do
    self.first = self.first.titleize
    self.last = self.last.titleize
  end
  
  def grade
    #change this to a more sphisticated calculation
    self.grades.map {|g| g.score }.sum
  end

  # def grades_where(type)
  #   self.assignments.where(type: type).map {|a| a.grades.where(student_id: id )}.flatten.sort_by {|e| e[:due]}.reverse!
  # end

  def grade_where(assign)
    grades.find_by(assignment_id: assign)
  end

  def grades_by_type(type)
    typeids = assignments.where(assign_type: type).map(&:id)
    grades.select {|g| typeids.include?(g.assignment_id)}
  end
end
