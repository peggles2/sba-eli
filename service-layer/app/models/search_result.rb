class SearchResult
  include Queryable

  # Results fields to be returned from the search
  attr_accessor :id, :name, :course_code, :content, :content_type,
                :learning_path_id, :learning_objective_id

  # Settings will have its own setter in order to deserialize the record from
  # the database
  attr_reader :settings

  # Custom setter for settings as the database field is serialized YAML
  def settings=(value)
    @settings = YAML.safe_load(value, [Symbol]) if value
  end
end
