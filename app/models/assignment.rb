class Assignment < ActiveRecord::Base
  belongs_to :course
  has_many :students, through: :course
  has_many :grades, dependent: :destroy
  has_many :notes, as: :notable
  validates :name, presence: true
  validates :due, presence: true
  before_save do
  	self.name = self.name.titleize
  end
end
