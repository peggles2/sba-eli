class FearlessRecord < ApplicationRecord
  self.abstract_class = true
  self.table_name_prefix = "fearless_"
end
