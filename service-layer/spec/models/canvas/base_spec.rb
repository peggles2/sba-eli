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

  describe "masquerade_current_user" do
    it "does not masquerade a user if Current.user is nil" do
      uri = "/api/v1/courses/70/modules"
      Current.user = nil
      expect(TestClass.masquerade_current_user(uri)).to eq(uri)
    end

    it "does masquerade a user if Current.user is not nil" do
      uri = "/api/v1/courses/70/modules"
      Current.user = User.new(id: 3)
      masqueraded_uri = "#{uri}?as_user_id=#{Current.user.id}"
      expect(TestClass.masquerade_current_user(uri)).to eq(masqueraded_uri)
    end
  end
end
