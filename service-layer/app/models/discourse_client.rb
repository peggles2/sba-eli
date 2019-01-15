module DiscourseClient
  ##
  # This method creates a instance of the Discourse API Client.
  def self.create
    client = DiscourseApi::Client.new(ENV["DISCOURSE_HOST"])
    client.api_username = ENV["DISCOURSE_USER"]
    client.api_key = ENV["DISCOURSE_API_KEY"]
    client
  end

  ##
  # This method creates a valid user object in discourse.
  def self.create_user(canvas_id, email, full_name)
    discourse_client = create
    discourse_client.create_user(
      name: full_name,
      email: email,
      password: SecureRandom.uuid,
      username: username_from_id(canvas_id),
      active: true,
    )
  end

  ##
  # The method takes an id from canvas and pads the value
  # with 0s such that the number is 20 characters long.
  # Discourse requires that a username be at least 3 characters
  # and not be an email address. Therefore we are using the
  # ID of the user in canvas padded by zeros.
  def self.username_from_id(id)
    id.to_s.rjust(20, "0")
  end
end
