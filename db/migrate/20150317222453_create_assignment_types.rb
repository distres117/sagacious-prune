class CreateAssignmentTypes < ActiveRecord::Migration
  def change
    create_table :assignment_types do |t|
      t.string :assign_type
      t.float :percentage
      t.references :course, index: true
      t.string :format
      t.timestamps null: false
    end
    add_foreign_key :assignment_types, :courses
  end
end
