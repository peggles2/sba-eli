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

    # Create the dicussion topic with a user that has elevated trust level

    topic_reponse = DiscourseClient.create.create_topic(
      skip_validations: true,
      title: "Discussion #{content_type} #{content_id}",
      raw: "System generated first reply for #{content_type} #{content_id}. Disregard",
    )

    discussion_map = DiscussionMap.create!(
      content_type: content_type,
      content_id: content_id,
      discussion_id: topic_reponse["topic_id"],
    )

    # Create reply to dicussion topic for a general user.
    # The topic return may contain a null response, because users that do not
    # have an appropriate level of trust, or who are under the approve post count
    # will be placed in to moderation for review

    self.response = client.create_post(
      topic_id: discussion_map.discussion_id,
      raw: raw,
      api_username: username,
    )

    if !response.nil?
      self.id = response["id"]
      self.body = response["cooked"]
      self.user_name = response["display_username"]
      self.user_title = response["user_title"]
      self.timestamp = response["created_at"]
      self.post_number = response["post_number"]
      self.reply_to_post_number = response["reply_to_post_number"]
    end

    true
  rescue DiscourseApi::UnauthenticatedError
    errors.add(:user, " is unable to post. Please contact the administrator.")
    false
  rescue DiscourseApi::Error => e
    Rail.logger.error e
    errors.add("An error was detected trying to post. Please contact the administrator.")
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
