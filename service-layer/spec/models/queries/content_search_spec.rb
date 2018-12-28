require "rails_helper"

describe Queries::ContentSearch do
  fixtures :all

  context "when per_page is included in the params" do
    it "returns the correct amount of records when per_page is 10" do
      params = { "per_page": "10" }
      results = described_class.call(params)
      expect(results.count).to eq(10)
    end
  end

  context "when per_page and page is included in the params" do
    it "it returns results for the last page" do
      params = { "per_page": "12", "page": "3" }
      results = described_class.call(params)
      expect(results.count).to eq(7)
    end
  end

  context "when keywords is included in the params" do
    it "returns learning paths that contain the keywords" do
      params = { "keywords": "Entrepreneurial Leadership" }
      results = described_class.call(params)
      expect(results.count).to eq(1)
    end

    it "returns learning objectives that contains keywords" do
      params = { "keywords": "Apply Best Practices of Communication. " }
      results = described_class.call(params)
      expect(results.count).to eq(1)
    end

    it "returns learning events that contains keywords" do
      params = { "keywords": "Test Topic" }
      results = described_class.call(params)
      expect(results.count).to eq(1)
    end
  end

  context "when subjects is included in the params" do
    it "returns results that are assigned a specific subject" do
      params = { "subjects": "Finance" }
      results = described_class.call(params)
      expect(results.count).to eq(1)
    end
  end

  context "when durations is included in the params" do
    it "return results that are signed to a specific duration" do
      params = { "durations": "long" }
      results = described_class.call(params)
      expect(results.count).to eq(1)
    end

    it "returns results for a list of durations" do
      params = { "durations": "long,short" }
      results = described_class.call(params)
      expect(results.count).to eq(2)
    end
  end

  context "when media_types is included in the params" do
    it "return results that are signed to a specific media_type" do
      params = { "media_types": "video" }
      results = described_class.call(params)
      expect(results.count).to eq(1)
    end

    it "returns results for a list of media_types" do
      params = { "durations": "video,podcast" }
      results = described_class.call(params)
      expect(results.count).to eq(2)
    end
  end
end
