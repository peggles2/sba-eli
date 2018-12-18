class CreateCustomContents < ActiveRecord::Migration[5.2]
  def change
    create_table :fearless_custom_contents do |t|
      t.string :contentable_type, null: false
      t.integer :contentable_id, null: false
      t.text :content
      t.timestamps
    end

    add_index :fearless_custom_contents,
              %w[contentable_type contentable_id],
              name: :idx_custom_contents_contentable_type_contentable_id,
              unique: true
  end
end
