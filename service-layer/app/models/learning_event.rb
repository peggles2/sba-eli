# == Schema Information
#
# Table name: content_tags
#
#  id                    :bigint(8)        not null, primary key
#  content_id            :bigint(8)
#  content_type          :string(255)
#  context_id            :bigint(8)        not null
#  context_type          :string(255)      not null
#  title                 :text
#  tag                   :string(255)
#  url                   :text
#  created_at            :datetime
#  updated_at            :datetime
#  comments              :text
#  tag_type              :string(255)      default("default")
#  context_module_id     :bigint(8)
#  position              :integer
#  indent                :integer
#  migration_id          :string(255)
#  learning_outcome_id   :bigint(8)
#  context_code          :string(255)
#  mastery_score         :float
#  rubric_association_id :bigint(8)
#  workflow_state        :string(255)      default("active"), not null
#  cloned_item_id        :bigint(8)
#  associated_asset_id   :bigint(8)
#  associated_asset_type :string(255)
#  new_tab               :boolean
#
# Indexes
#
#  index_content_tags_on_associated_asset             (associated_asset_id,associated_asset_type)
#  index_content_tags_on_content_id_and_content_type  (content_id,content_type)
#  index_content_tags_on_context_id_and_context_type  (context_id,context_type)
#  index_content_tags_on_context_module_id            (context_module_id)
#  index_content_tags_on_learning_outcome_id          (learning_outcome_id) WHERE (learning_outcome_id IS NOT NULL)
#
# Foreign Keys
#
#  fk_rails_...  (cloned_item_id => cloned_items.id)
#  fk_rails_...  (context_module_id => context_modules.id)
#  fk_rails_...  (learning_outcome_id => learning_outcomes.id)
#

class LearningEvent < ApplicationRecord
  include Contentable

  self.table_name = "content_tags"

  acts_as_taggable_on :duration
  acts_as_taggable_on :media_types
  acts_as_taggable_on :subjects
end
