# This migration comes from acts_as_taggable_on_engine (originally 6)
if ActiveRecord.gem_version >= Gem::Version.new("5.0")
  class AddMissingIndexesOnTaggings < ActiveRecord::Migration[4.2]; end
else
  class AddMissingIndexesOnTaggings < ActiveRecord::Migration; end
end
# rubocop:disable Metrics/BlockLength, Metrics/PerceivedComplexity
AddMissingIndexesOnTaggings.class_eval do
  def change
    unless index_exists? ActsAsTaggableOn.taggings_table, :tag_id
      add_index ActsAsTaggableOn.taggings_table, :tag_id
    end

    unless index_exists? ActsAsTaggableOn.taggings_table, :taggable_id
      add_index ActsAsTaggableOn.taggings_table, :taggable_id
    end

    unless index_exists? ActsAsTaggableOn.taggings_table, :taggable_type
      add_index ActsAsTaggableOn.taggings_table, :taggable_type
    end

    unless index_exists? ActsAsTaggableOn.taggings_table, :tagger_id
      add_index ActsAsTaggableOn.taggings_table, :tagger_id
    end

    unless index_exists? ActsAsTaggableOn.taggings_table, :context
      add_index ActsAsTaggableOn.taggings_table, :context
    end

    unless index_exists? ActsAsTaggableOn.taggings_table, %i[tagger_id tagger_type]
      add_index ActsAsTaggableOn.taggings_table, %i[tagger_id tagger_type]
    end

    unless index_exists? ActsAsTaggableOn.taggings_table,
        %i[taggable_id taggable_type tagger_id context], name: "taggings_idy"
      add_index ActsAsTaggableOn.taggings_table,
        %i[taggable_id taggable_type tagger_id context],
        name: "taggings_idy"
    end
  end
end
# rubocop:enable Metrics/BlockLength, Metrics/PerceivedComplexity
