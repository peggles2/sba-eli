class CreateAssessments < ActiveRecord::Migration[5.2]
  def change
    create_table :fearless_assessments do |t|
      t.integer :course_id, null: false
      t.integer :quiz_id, null: false
      t.string :name
      t.text :description
      t.decimal :minimum
      t.decimal :maximum

      t.timestamps
    end
  end
end
