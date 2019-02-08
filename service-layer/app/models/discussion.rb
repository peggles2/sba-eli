class Discussion
  include ActiveModel::Model

  attr_accessor :id,
                :content_type,
                :content_id,
                :discussion_id,
                :body,
                :raw,
                :response,
                :user_img,
                :user_name,
                :user_title,
                :timestamp,
                :replies,
                :post_number,
                :reply_to_post_number,
                :user

  validates :raw, presence: true
  validates :user, :content_type, :content_id, presence: true

  def create
    return false unless valid?

    self.response = client.create_topic(
      skip_validations: true,
      title: "Discussion #{content_type} #{content_id}",
      raw: raw,
    )

    DiscussionMap.create!(
      content_type: content_type,
      content_id: content_id,
      discussion_id: response["topic_id"],
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

  private

  def client
    @client ||= DiscourseClient.create(user: username)
  end

  def username
    @username ||= DiscourseClient.username_from_id(user.id)
  end
end
