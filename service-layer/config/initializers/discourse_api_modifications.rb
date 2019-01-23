##
# This is a monkey patch for the create_posts method of the
# DiscourseApi. This method adds reply_to_post_number which is not
# sent in the gem implementation.
module DiscourseApi
  module API
    module Posts
      def create_post(args)
        args = API.params(args).
          required(:topic_id, :raw).
          optional(:created_at, :api_username, :reply_to_post_number)
        post("/posts", args)
      end
    end
  end
end
