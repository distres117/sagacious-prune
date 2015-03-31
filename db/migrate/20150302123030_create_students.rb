class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first
      t.string :last
      t.integer :absences
      t.references :course, index: true
      t.timestamps null: false
    end
    add_foreign_key :students, :courses
  end
end
