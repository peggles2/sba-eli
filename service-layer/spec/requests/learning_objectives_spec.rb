require "rails_helper"

describe "LearningObjectives" do
  describe "GET /learning_objectives" do
    it "gets a list of all learning objectives" do
      VCR.use_cassette("learning_objectives/get_learning_objectives") do
        course_id = 1
        get "/learning_objectives?course_id=#{course_id}"
        json = JSON.parse(response.body)

        expect(response).to be_successful
        expect(json.size).to eq(10)
        expect(json[0]["name"]).to eq("Update Postman Name 19")
      end
    end
  end

  describe "GET learning_objectives/:id" do
    it "gets a single learning objective" do
      VCR.use_cassette("learning_objectives/get_learning_objective") do
        course_id = 1
        lo_id = 11
        get "/learning_objectives/#{lo_id}?course_id=#{course_id}"
        json = JSON.parse(response.body)

        expect(response).to be_successful
        expect(json["name"]).to eq("Test Module Name Updated")
      end
    end
  end

  describe "POST learning_objectives" do
    it "creates a single learning objective" do
      VCR.use_cassette("learning_objectives/create_learning_objective") do
        course_id = 1

        url = "/learning_objectives?course_id=#{course_id}"
        post url, params: { name: "Rspec Test Module Name" }
        json = JSON.parse(response.body)

        expect(response).to be_successful
        expect(json["name"]).to eq("Rspec Test Module Name")
      end
    end
  end

  describe "DELETE learning_objectives/:id" do
    it "deletes a single learning objective" do
      VCR.use_cassette("learning_objectives/delete_learning_objective") do
        course_id = 1
        lo_id = 23
        delete "/learning_objectives/#{lo_id}?course_id=#{course_id}"
        json = JSON.parse(response.body)

        expect(response).to be_successful
        expect(json["name"]).to eq("Rspec Test Module Name")
      end
    end
  end

  describe "PUT learning_objectives/:id" do
    it "updates a single learning objective" do
      VCR.use_cassette("learning_objectives/update_learning_objective") do
        course_id = 1
        lo_id = 16
        url = "/learning_objectives/#{lo_id}?course_id=#{course_id}"
        put url, params: { name: "Rspec Test Updated Module Name" }
        json = JSON.parse(response.body)

        expect(response).to be_successful
        expect(json["name"]).to eq("Rspec Test Updated Module Name")
      end
    end
  end
end
