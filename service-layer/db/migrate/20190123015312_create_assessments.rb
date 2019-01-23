class CreateAssessments < ActiveRecord::Migration[5.2]
  def change
    create_table :fearless_assessments do |t|
      t.integer :course_id
      t.integer :quiz_id
      t.string :name
      t.text :description
      t.decimal :minimum
      t.decimal :maximum

      t.timestamps
    end
  end
end
