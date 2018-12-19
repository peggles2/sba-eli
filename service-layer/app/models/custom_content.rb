class CustomContent < FearlessRecord
  belongs_to :contentable, polymorphic: true

  validates_presence_of :contentable_type, :contentable_id, :content
end
