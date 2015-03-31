class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.float :score
      t.references :student, index: true
      t.references :assignment, index: true
      t.timestamps null: false
    end
    add_foreign_key :grades, :students
    add_foreign_key :grades, :assignments
  end
end
