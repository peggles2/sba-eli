require "rails_helper"

class TestClass
  include Canvas::Base
end

describe "Canvas::Base" do
  it "returns the current canvas session_token" do
    expect(TestClass.session_token).to eq(ENV["CANVAS_TOKEN"])
  end

  it "returns the canvas_host" do
    expect(TestClass.canvas_host).to eq(ENV["CANVAS_HOST"])
  end

  it "returns base_options" do
    header = {
      headers: {
        "Authorization" => "Bearer " + ENV["CANVAS_TOKEN"],
      },
    }

    expect(TestClass.base_options).to eq(header)
  end

  describe "masquerade_current_user_query" do
    it "does not masquerade a user if Current.user is nil" do
      uri = {}
      Current.user = nil
      expect(TestClass.masquerade_current_user_query).to eq(uri)
    end

    it "does masquerade a user if Current.user is not nil" do
      Current.user = User.new(id: 3)
      masqueraded_query = { "as_user_id" => Current.user.id }
      expect(TestClass.masquerade_current_user_query).to eq(masqueraded_query)
    end
  end

  describe "custom_options" do
    it "should add paginated query param when passing per_page" do
      paginated_options = TestClass.base_options.merge(query: { "per_page" => 75 })

      expect(TestClass.custom_options(per_page: 75)).to eq(paginated_options)
    end

    it "should add masqueraded user query param with masquerade option and logged in" do
      Current.user = User.new(id: 3)
      masqueraded_options = TestClass.base_options.merge(query: { "as_user_id" => Current.user.id })
      expect(TestClass.custom_options(masquerade: true)).to eq(masqueraded_options)
    end

    it "should add masqueraded and pagninated query params" do
      Current.user = User.new(id: 3)
      options = TestClass.base_options.merge(query: { "as_user_id" => Current.user.id,
                                                      "per_page" => 50 })
      expect(TestClass.custom_options(masquerade: true, per_page: 50)).to eq(options)
    end
  end
end
