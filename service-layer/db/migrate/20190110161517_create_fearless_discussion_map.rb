class CreateFearlessDiscussionMap < ActiveRecord::Migration[5.2]
  def change
    create_table :fearless_discussion_maps do |t|
      t.integer :discussion_id, null: false
      t.string :content_type, null: false
      t.integer :content_id, null: false
      t.timestamps
    end
    add_index :fearless_discussion_maps, :discussion_id, unique: true
  end
end
