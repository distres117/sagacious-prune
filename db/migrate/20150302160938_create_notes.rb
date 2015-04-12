class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :notable, index: true
      t.string :notable_type
      t.text :content
      t.timestamps null: false
    end
  end
end
