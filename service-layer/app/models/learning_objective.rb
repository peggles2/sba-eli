# == Schema Information
#
# Table name: context_modules
#
#  id                          :bigint(8)        not null, primary key
#  context_id                  :bigint(8)        not null
#  context_type                :string(255)      not null
#  name                        :text
#  position                    :integer
#  prerequisites               :text
#  completion_requirements     :text
#  created_at                  :datetime
#  updated_at                  :datetime
#  workflow_state              :string(255)      default("active"), not null
#  deleted_at                  :datetime
#  unlock_at                   :datetime
#  migration_id                :string(255)
#  require_sequential_progress :boolean
#  cloned_item_id              :bigint(8)
#  completion_events           :text
#  requirement_count           :integer
#
# Indexes
#
#  index_context_modules_on_context_id_and_context_type  (context_id,context_type)
#
# Foreign Keys
#
#  fk_rails_...  (cloned_item_id => cloned_items.id)
#

class LearningObjective < ApplicationRecord
  include Contentable

  self.table_name = "context_modules"

  acts_as_taggable_on :subjects
  acts_as_taggable_on :duration
end
