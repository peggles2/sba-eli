class CreateLearningPathCustomData < ActiveRecord::Migration[5.2]
  def change
    create_table :fearless_learning_path_custom_data do |t|
      t.integer :learning_path_id, null: false

      t.string :time
      t.string :description
      t.string :thumbnail_url

      t.timestamps
    end
    add_index :fearless_learning_path_custom_data, :learning_path_id, unique: true
  end
end
