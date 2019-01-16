json.array! @discussion_replies do |reply|
  json.partial! "result", locals: { reply: reply }
end
