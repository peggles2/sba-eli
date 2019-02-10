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

    topic_id = 10

    if !self.response.nil? 
      # Topic did not need to be moderated and the response came back as expected
      topic_id = response["topic_id"]
    else 
      # Since we get back a null response for items that go into moderation
      # We can set the topic value manually by checking our table and grabbing 
      # heighest value topic id
      topic_id = DiscussionMap.maximum("discussion_id")

      # If there are no values in our table, start the topic id beyond the 
      # default topic ids in discourse
      if topic_id.nil? || topic_id.to_i < 10
        topic_id = 9
      end

      # Increment whatever id is the max by one to get the next available id
      topic_id = topic_id.to_i + 1
    end
  
    self.response = client.create_topic(
      topic_id: topic_id,
      skip_validations: true,
      title: "Discussion #{content_type} #{content_id}",
      raw: raw,
    )

    DiscussionMap.create!(
      content_type: content_type,
      content_id: content_id,
      discussion_id: topic_id,
    )

    if !self.response.nil?
      self.id = response["id"]
      self.body = response["cooked"]
      self.user_name = response["display_username"]
      self.user_title = response["user_title"]
      self.timestamp = response["created_at"]
      self.post_number = response["post_number"]
      self.reply_to_post_number = response["reply_to_post_number"]
    else
      # How do we want to capture the null that comes back from discourse?
    end

    true
  rescue DiscourseApi::UnauthenticatedError
    errors.add(:user, " is unable to post. Please contact the administrator.")
    false
  rescue DiscourseApi::Error
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
