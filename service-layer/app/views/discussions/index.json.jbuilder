json.post_count @post_count

json.replies @discussion_replies do |reply|
  json.partial! "result", locals: { reply: reply }
end
