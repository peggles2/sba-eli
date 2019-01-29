class AddLearningEventCustomData < ActiveRecord::Migration[5.2]
  def change
    create_table :fearless_event_custom_data do |t|
      t.integer :event_id, null: false

      t.string :time
      t.string :description
      t.string :thumbnail_url
      t.string :event_type

      t.timestamps
    end
    add_index :fearless_event_custom_data, :event_id, unique: true
  end
end
