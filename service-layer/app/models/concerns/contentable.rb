# The Contentable Concern allows you to quickly add a relationship between
# a model and CustomContent. Here is an example of its use:
#
#   class LearningPath < ApplicationRecord
#     include Contentable
#   end
#
#   learning_path = LearningPath.find(1)
#   learning_path.custom_content # Returns the custom_content assoicated with the learning_path
module Contentable
  extend ActiveSupport::Concern

  included  do
    has_one :custom_content, as: :contentable, dependent: :destroy
  end
end
