module Canvas
  module LearningEvent
    include Canvas::Base
    include HTTParty

    base_uri ENV["CANVAS_HOST"] + "/api/v1"

    def self.all(course_id, module_id)
      JSON.parse get("/courses/#{course_id}/modules/#{module_id}/items", base_options).body
    end

    def self.find(course_id, module_id, id)
      url = "/courses/#{course_id}/modules/#{module_id}/items/#{id}"
      learning_event = get(url, base_options)
      if learning_event["url"]
        learning_event["eventContent"] = get(learning_event["url"], base_options)
      end

      learning_event
    end

    def self.update(course_id, module_id, id, le_params)
      options = base_options.merge!(body: le_params.to_json)
      JSON.parse put("/courses/#{course_id}/modules/#{module_id}/items/#{id}", options).body
    end

    def self.destroy(course_id, module_id, id)
      JSON.parse delete("/courses/#{course_id}/modules/#{module_id}/items/#{id}", base_options).body
    end
  end
end
