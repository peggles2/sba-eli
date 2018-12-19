# == Schema Information
#
# Table name: content_tags
#
#  id                    :bigint(8)        not null, primary key
#  content_id            :bigint(8)
#  content_type          :string(255)
#  context_id            :bigint(8)        not null
#  context_type          :string(255)      not null
#  title                 :text
#  tag                   :string(255)
#  url                   :text
#  created_at            :datetime
#  updated_at            :datetime
#  comments              :text
#  tag_type              :string(255)      default("default")
#  context_module_id     :bigint(8)
#  position              :integer
#  indent                :integer
#  migration_id          :string(255)
#  learning_outcome_id   :bigint(8)
#  context_code          :string(255)
#  mastery_score         :float
#  rubric_association_id :bigint(8)
#  workflow_state        :string(255)      default("active"), not null
#  cloned_item_id        :bigint(8)
#  associated_asset_id   :bigint(8)
#  associated_asset_type :string(255)
#  new_tab               :boolean
#
# Indexes
#
#  index_content_tags_on_associated_asset             (associated_asset_id,associated_asset_type)
#  index_content_tags_on_content_id_and_content_type  (content_id,content_type)
#  index_content_tags_on_context_id_and_context_type  (context_id,context_type)
#  index_content_tags_on_context_module_id            (context_module_id)
#  index_content_tags_on_learning_outcome_id          (learning_outcome_id) WHERE (learning_outcome_id IS NOT NULL)
#
# Foreign Keys
#
#  fk_rails_...  (cloned_item_id => cloned_items.id)
#  fk_rails_...  (context_module_id => context_modules.id)
#  fk_rails_...  (learning_outcome_id => learning_outcomes.id)
#

require "rails_helper"

describe "LearningEvents" do
  fixtures :content_tags

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
  describe "GET /learning_events/:learning_path_id/custom_content" do
    it "gets an empty content object if there is not content found" do
      learning_path_id = 1
      get "/learning_events/#{learning_path_id}/custom_content"
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["content"]).to be_nil
    end

    it "gets the custom content if it exists" do
      content = create(:custom_content, contentable_type: "LearningEvent", contentable_id: 2)

      get "/learning_events/#{content.contentable_id}/custom_content"
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["content"]).to eq(content.content)
    end
  end

  describe "POST /learning_events/:learning_path_id/custom_content" do
    it "creates custom content for a learning path" do
      content = build(:custom_content, contentable_type: "LearningEvent", contentable_id: 3)
      params = { custom_content: { content: content.content } }

      post "/learning_events/#{content.contentable_id}/custom_content", params: params
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["content"]).to eq(content.content)
    end
  end

  describe "PUT /learning_events/:learning_path_id/custom_content" do
    it "updates custom content for a learning path" do
      content = create(:custom_content, contentable_type: "LearningEvent", contentable_id: 4)
      new_content = "This is the new content to be written"
      params = { custom_content: { content: new_content } }

      put "/learning_events/#{content.contentable_id}/custom_content", params: params
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["content"]).to eq(new_content)
    end
  end
end
