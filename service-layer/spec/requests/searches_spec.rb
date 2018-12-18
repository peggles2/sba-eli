require "rails_helper"

describe "Searches" do
  fixtures :all

  describe "GET /search" do
    it "gets the first page of results when no query parameters are passed" do
      get "/search"
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["data"].size).to eq(20)
    end

    it "gets results sfor the last page" do
      get "/search?per_page=12&page=3"
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["data"].size).to eq(7)
    end

    it "gets results for learning paths that contain the keywords" do
      get "/search?keywords=Entrepreneurial%20Leadership"
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["data"].size).to eq(1)
    end

    it "gets results for learning objectives that contains keywords" do
      get "/search?keywords=Apply%20Best%20Practices%20of%20Communication."
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["data"].size).to eq(1)
    end

    it "gets results for llearning events that contains keywords" do
      get "/search?keywords=Test%20Topic"
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["data"].size).to eq(1)
    end

    it "gets results that are signed to a specific duration" do
      get "/search?durations=long"
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["data"].size).to eq(1)
    end

    it "gets results that are assigned for a list of durations" do
      get "/search?durations=long,short"
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["data"].size).to eq(2)
    end

    it "gets results that are signed to a specific media_type" do
      get "/search?media_types=video"
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["data"].size).to eq(1)
    end

    it "gets results that are assigned for a list of media_types" do
      get "/search?media_types=video,podcast"
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["data"].size).to eq(2)
    end

    it "gets results that are assigned to a specific subject" do
      get "/search?subjects=Finance"
      json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(json["data"].size).to eq(1)
    end
  end
end
