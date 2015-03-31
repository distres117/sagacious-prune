class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.datetime :assigned
      t.datetime :due
      t.references :course, index: true
      t.string :assign_type
      t.timestamps null: false
    end
    add_foreign_key :assignments, :courses
  end
end
