module Canvas
  module LearningEvent
    include Canvas::Base
    include HTTParty

    base_uri ENV["CANVAS_HOST"] + "/api/v1"

    def self.all(course_id, module_id)
      uri = masquerade_current_user("/courses/#{course_id}/modules/#{module_id}/items")
      results = JSON.parse get(uri, base_options).body
      results.each do |event|
        custom_data = EventCustomData.where(event_id: event['id']).first
        event['custom_data'] = custom_data if custom_data
      end
      results
    end

    def self.find(course_id, module_id, id)
      url = masquerade_current_user("/courses/#{course_id}/modules/#{module_id}/items/#{id}")
      learning_event = get(url, base_options)
      if learning_event["url"]
        learning_event["eventContent"] = get(learning_event["url"], base_options)
      end
      custom_data = EventCustomData.where(event_id: learning_event['id']).first
      learning_event['custom_data'] = custom_data if custom_data

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
      uri = masquerade_current_user("/courses/#{course_id}/modules/#{module_id}/"\
            "items/#{id}/mark_read")
      JSON.parse post(uri, base_options).body
    end
  end
end
