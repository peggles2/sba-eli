# == Schema Information
#
# Table name: content_tags
#
#  id                    :bigint(8)        not null
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

class LearningEvent < ApplicationRecord
  include Contentable

  self.table_name = "content_tags"

  acts_as_taggable_on :duration
  acts_as_taggable_on :media_types
  acts_as_taggable_on :subjects
end
