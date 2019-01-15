module Mocks
  module DiscourseHelper
    include RequestHelper

    def stub_discourse_create_user(options = {})
      id = options.fetch(:id, 10)
      status = options.fetch(:status, 200)

      response = {
        "success": true,
        "active": true,
        "message": "Your account is activated and ready to use.",
        "user_id": id,
      }

      url = "#{ENV['DISCOURSE_HOST']}/users?api_key=#{ENV['DISCOURSE_API_KEY']}"\
            "&api_username=#{ENV['DISCOURSE_USER']}"

      response_body = options.fetch(:response_body, response.to_json)
      stub_request(:post, url).to_return(status: status, body: response_body)
    end

    def stub_discourse_create_post(options = {})
      user_id = options.fetch(:user_id, 3)
      username = options.fetch(:username, "00000000000000000003")
      raw = options.fetch(:raw, "This is the content of the post. Needs to be over 20 characters")
      status = options.fetch(:status, 200)

      response = {
        "id": 27,
        "name": nil,
        "username": username,
        "avatar_template": "/letter_avatar_proxy/v2/letter/0/a183cd/{size}.png",
        "created_at": "2019-01-15T13:13:07.424Z",
        "cooked": "<p>“#{raw}”</p>",
        "post_number": 7,
        "post_type": 1,
        "updated_at": "2019-01-15T13:13:07.424Z",
        "reply_count": 0,
        "reply_to_post_number": nil,
        "quote_count": 0,
        "avg_time": nil,
        "incoming_link_count": 0,
        "reads": 0,
        "score": 0,
        "yours": true,
        "topic_id": 7,
        "topic_slug": "welcome-to-discourse",
        "display_username": nil,
        "primary_group_name": nil,
        "primary_group_flair_url": nil,
        "primary_group_flair_bg_color": nil,
        "primary_group_flair_color": nil,
        "version": 1,
        "can_edit": true,
        "can_delete": true,
        "can_recover": nil,
        "can_wiki": true,
        "user_title": nil,
        "actions_summary": [{
          "id": 3,
          "can_act": true,
        }, {
          "id": 4,
          "can_act": true,
        }, {
          "id": 8,
          "can_act": true,
        }, {
          "id": 7,
          "can_act": true,
        }],
        "moderator": false,
        "admin": true,
        "staff": true,
        "user_id": user_id,
        "draft_sequence": 6,
        "hidden": false,
        "trust_level": 1,
        "deleted_at": nil,
        "user_deleted": false,
        "edit_reason": nil,
        "can_view_edit_history": true,
        "wiki": false,
      }

      url = "#{ENV['DISCOURSE_HOST']}/posts?api_key=#{ENV['DISCOURSE_API_KEY']}"\
            "&api_username=#{username}"

      response_body = options.fetch(:response_body, response.to_json)

      stub_request(:post, url).to_return(status: status, body: response_body)
    end
  end
end
