class SearchResult
  include Queryable

  attr_accessor :id, :name, :course_code, :content, :content_type,
                :learning_path_id, :learning_objective_id

  attr_reader :settings

  def settings=(value)
    @settings = YAML.safe_load(value, [Symbol]) if value
  end
end
