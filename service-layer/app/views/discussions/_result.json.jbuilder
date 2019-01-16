json.id reply.id
json.content_type reply.content_type
json.user_img reply.user_img
json.user_name reply.user_name
json.timestamp reply.timestamp
json.user_title reply.user_title
json.post_number reply.post_number
json.reply_to_post_number reply.reply_to_post_number
json.body reply.body

json.replies reply.replies do |r|
  json.partial! "result", locals: { reply: r }
end
