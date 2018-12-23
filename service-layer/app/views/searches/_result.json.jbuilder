json.id result.id
json.name result.name
json.description result.content
json.content_type result.content_type
json.uri construct_uri(result)
json.meta_data do
  json.learning_path_id default_meta_id(result.learning_path_id)
  json.learning_objective_id default_meta_id(result.learning_objective_id)
  if result.content_type == "learning_event"
    json.learning_event_id default_meta_id(result.id)
  end
end
json.thumbnail result.settings ? result.settings[:image_url] : nil
