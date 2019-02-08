class DiscussionReply
  include ActiveModel::Model

  attr_accessor :id,
                :discussion_id,
                :body,
                :raw,
                :response,
                :user_img,
                :user_name,
                :user_title,
                :timestamp,
                :post_number,
                :reply_to_post_number,
                :user

  validates :discussion_id, presence: true
  validates :raw, presence: true
  validates :user, presence: true

  def create
    return false unless valid?

    self.response = client.create_post(
      topic_id: discussion_id,
      reply_to_post_number: reply_to_post_number,
      raw: raw,
      api_username: username,
    )

    self.id = response["id"]
    self.body = response["cooked"]
    self.user_name = response["display_username"]
    self.user_title = response["user_title"]
    self.timestamp = response["created_at"]
    self.post_number = response["post_number"]
    self.reply_to_post_number = response["reply_to_post_number"]

    true
  rescue DiscourseApi::UnauthenticatedError
    errors.add(:user, " is unable to post. Please contact the administrator.")
    false
  end

  def content_type
    "comment"
  end

  def replies=(value)
    @replies = value
  end

  def replies
    @replies || []
  end

  class << self
    def from_discourse_list(reponse)
      posts_hash = reponse["post_stream"]["posts"]

      # create collection of all top level posts
      post_list = posts_hash.reject { |r| r["reply_to_post_number"].present? }.
        map { |reply| DiscussionReply.from_hash(reply) }

      # fill top level posts with replies
      post_list.each do |post|
        post.replies = posts_hash.
          select { |r| r["reply_to_post_number"].to_i == post.post_number.to_i }.
          map { |reply| DiscussionReply.from_hash(reply) }
      end
    end

    def from_hash(reply)
      DiscussionReply.new(
        id: reply["id"],
        body: reply["cooked"],
        user_name: reply["display_username"],
        user_title: reply["user_title"],
        timestamp: reply["created_at"],
        post_number: reply["post_number"],
        reply_to_post_number: reply["reply_to_post_number"],
      )
    end
  end

  private

  def client
    @client ||= DiscourseClient.create(user: username)
  end

  def username
    @username ||= DiscourseClient.username_from_id(user.id)
  end
end
