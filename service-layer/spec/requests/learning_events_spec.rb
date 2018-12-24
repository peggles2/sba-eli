require "rails_helper"

describe "LearningEvents" do
  describe "GET /learning_events" do
    it "gets a list of all learning events" do
      VCR.use_cassette("learning_events/get_learning_events") do
        course_id = 1
        module_id = 1
        get "/learning_events?course_id=#{course_id}&module_id=#{module_id}"
        json = JSON.parse(response.body)

        expect(response).to be_successful
        expect(json.size).to eq(3)
        expect(json[0]["title"]).to eq("Test Assignment")
      end
    end
  end

  describe "GET learning_events/:id" do
    it "gets a single learning event" do
      VCR.use_cassette("learning_events/get_learning_event") do
        course_id = 1
        module_id = 2
        le_id = 4
        get "/learning_events/#{le_id}?course_id=#{course_id}&module_id=#{module_id}"
        json = JSON.parse(response.body)

        expect(response).to be_successful
        expect(json["title"]).to eq("Postman Test Update Rename")
      end
    end
  end

  describe "DELETE learning_events/:id" do
    it "deletes a single learning event" do
      VCR.use_cassette("learning_events/delete_learning_event") do
        course_id = 1
        module_id = 2
        le_id = 8
        delete "/learning_events/#{le_id}?course_id=#{course_id}&module_id=#{module_id}"
        json = JSON.parse(response.body)

        expect(response).to be_successful
        expect(json["title"]).to eq("Test Quiz To Delete")
      end
    end
  end

  describe "PUT learning_events/:id" do
    it "updates a single learning event" do
      VCR.use_cassette("learning_events/update_learning_event") do
        course_id = 1
        module_id = 1
        le_id = 3
        params = { params: { module_item: { "title": "Updated Rspec Title" } } }

        # rubocop:disable Rails/HttpPositionalArguments
        put "/learning_events/#{le_id}?course_id=#{course_id}&module_id=#{module_id}", params
        # rubocop:enable Rails/HttpPositionalArguments
        json = JSON.parse(response.body)

        expect(response).to be_successful
        expect(json["title"]).to eq("Updated Rspec Title")
      end
    end
  end
end
