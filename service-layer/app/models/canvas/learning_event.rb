module Canvas
  module LearningEvent
    include Canvas::Base
    include HTTParty

    base_uri ENV["CANVAS_HOST"] + "/api/v1"

    def self.all(course_id, module_id)
      uri = "/courses/#{course_id}/modules/#{module_id}/items"
      options = custom_options(masquerade: true, per_page: 100)

      results = JSON.parse get(uri, options).body
      results.each do |event|
        custom_data = EventCustomData.where(event_id: event["id"]).first
        event["custom_data"] = custom_data if custom_data
      end
      results
    end

    def self.find(course_id, module_id, id)
      uri = "/courses/#{course_id}/modules/#{module_id}/items/#{id}"
      options = custom_options(masquerade: true)

      learning_event = get(uri, options)
      if learning_event["url"]
        learning_event["eventContent"] = get(learning_event["url"], base_options)
      end
      custom_data = EventCustomData.where(event_id: learning_event["id"]).first
      learning_event["custom_data"] = custom_data if custom_data

      learning_event
    end

    def self.update(course_id, module_id, id, le_params)
      options = base_options.merge!(body: le_params.to_json)
      JSON.parse put("/courses/#{course_id}/modules/#{module_id}/items/#{id}", options).body
    end

    def self.destroy(course_id, module_id, id)
      JSON.parse delete("/courses/#{course_id}/modules/#{module_id}/items/#{id}", base_options).body
    end

    def self.done(course_id, module_id, id)
      uri = "/courses/#{course_id}/modules/#{module_id}/items/#{id}/mark_read"
      options = custom_options(masquerade: true)

      JSON.parse post(uri, options).body
    end
  end
end
