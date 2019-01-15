class DiscussionReply
  include ActiveModel::Model

  attr_accessor :discussion_id, :raw, :response, :user

  validates :discussion_id, presence: true
  validates :raw, presence: true, length: { minimum: 20 }
  validates :user, presence: true

  def create
    return unless valid?

    self.response = client.create_post(
      topic_id: discussion_id,
      raw: raw,
      api_username: username,
    )
    true
  rescue DiscourseApi::UnauthenticatedError
    errors.add(:user, "is unable to post. Please contact the administrator.")
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
