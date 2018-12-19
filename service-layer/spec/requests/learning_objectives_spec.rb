# == Schema Information
#
# Table name: context_modules
#
#  id                          :bigint(8)        not null, primary key
#  context_id                  :bigint(8)        not null
#  context_type                :string(255)      not null
#  name                        :text
#  position                    :integer
#  prerequisites               :text
#  completion_requirements     :text
#  created_at                  :datetime
#  updated_at                  :datetime
#  workflow_state              :string(255)      default("active"), not null
#  deleted_at                  :datetime
#  unlock_at                   :datetime
#  migration_id                :string(255)
#  require_sequential_progress :boolean
#  cloned_item_id              :bigint(8)
#  completion_events           :text
#  requirement_count           :integer
#
# Indexes
#
#  index_context_modules_on_context_id_and_context_type  (context_id,context_type)
#
# Foreign Keys
#
#  fk_rails_...  (cloned_item_id => cloned_items.id)
#

require "rails_helper"

describe "LearningObjectives" do
  fixtures :context_modules

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

  describe "GET /learning_objectives/:learning_path_id/custom_content" do
    it "gets an empty content object if there is not content found" do
      learning_path_id = 1
      get "/learning_objectives/#{learning_path_id}/custom_content"
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["content"]).to be_nil
    end

    it "gets the custom content if it exists" do
      content = create(:custom_content, contentable_type: "LearningObjective", contentable_id: 2)

      get "/learning_objectives/#{content.contentable_id}/custom_content"
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["content"]).to eq(content.content)
    end
  end

  describe "POST /learning_objectives/:learning_path_id/custom_content" do
    it "creates custom content for a learning path" do
      content = build(:custom_content, contentable_type: "LearningObjective", contentable_id: 3)
      params = { custom_content: { content: content.content } }

      post "/learning_objectives/#{content.contentable_id}/custom_content", params: params
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["content"]).to eq(content.content)
    end
  end

  describe "PUT /learning_objectives/:learning_path_id/custom_content" do
    it "updates custom content for a learning path" do
      content = create(:custom_content, contentable_type: "LearningObjective", contentable_id: 4)
      new_content = "This is the new content to be written"
      params = { custom_content: { content: new_content } }

      put "/learning_objectives/#{content.contentable_id}/custom_content", params: params
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["content"]).to eq(new_content)
    end
  end
end
