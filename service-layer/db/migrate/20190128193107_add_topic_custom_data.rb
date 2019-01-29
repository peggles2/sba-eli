class AddTopicCustomData < ActiveRecord::Migration[5.2]
  def change
    create_table :fearless_topic_custom_data do |t|
      t.integer :topic_id, null: false

      t.string :time
      t.string :description
      t.string :thumbnail_url

      t.timestamps
    end
    add_index :fearless_topic_custom_data, :topic_id, unique: true
  end
end
