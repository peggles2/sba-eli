module DiscourseClient
  def self.create
    client = DiscourseApi::Client.new(ENV["DISCOURSE_HOST"])
    client.api_username = ENV["DISCOURSE_USER"]
    client.api_key = ENV["DISCOURSE_API_KEY"]
    client
  end
end
