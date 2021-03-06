module Canvas
  module LearningPath
    include Canvas::Base
    include HTTParty

    base_uri ENV["CANVAS_HOST"] + "/api/v1"

    def self.all
      result = JSON.parse get("/courses", base_options).body
      result.each do |learning_path|
        custom_data = LearningPathCustomData.where(learning_path_id: learning_path["id"]).first
        learning_path["custom_data"] = custom_data if custom_data
      end
      result
    end

    def self.find(id)
      learning_path = JSON.parse get("/courses/#{id}", base_options).body
      custom_data = LearningPathCustomData.where(learning_path_id: learning_path["id"]).first
      learning_path["custom_data"] = custom_data if custom_data
      learning_path
    end

    def self.create(account_id, lp_params)
      options = base_options.merge!(body: lp_params)
      JSON.parse post("/accounts/#{account_id}\/courses", options)
    end

    def self.update(id, lp_params)
      @params = {
        "id": id,
        "course[name]": lp_params.fetch(:name, ""),
        "course[course_code]": lp_params.fetch(:course_code, ""),
      }

      options = base_options.merge!(body: @params)
      JSON.parse put("/courses/#{id}", options).body
    end

    def self.destroy(id)
      options = base_options.merge!(body: { "event": "delete" })
      JSON.parse delete("/courses/#{id}", options).body
    end

    def self.enroll(id, user)
      params = {
        "enrollment[user_id]": user.id,
        "enrollment[type]": "StudentEnrollment",
        "enrollment[enrollment_state]": "active",
        "enrollment[notify]": false,
      }
      options = base_options.merge!(body: params)
      JSON.parse post("/courses/#{id}/enrollments", options).body
    end

    def self.progress
      uri = "/courses/?include[]=course_progress&as_user_id=#{Current.user&.id}"
      JSON.parse get(uri, base_options).body
    end

    def self.check_progress(id)
      uri = "/courses/#{id}?include[]=course_progress&as_user_id=#{Current.user&.id}"
      JSON.parse get(uri, base_options).body
    end
  end
end
