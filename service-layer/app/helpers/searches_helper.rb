module SearchesHelper
  def construct_uri(result)
    case result.content_type
    when "learning_path"
      learning_path_path(result.id)
    when "learning_objective"
      learning_objective_path(result.id)
    when "learning_event"
      learning_event_path(result.id)
    end
  end

  def default_meta_id(value)
    value.zero? ? nil : value
  end
end
