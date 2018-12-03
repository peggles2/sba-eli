module Canvas
  module LearningObjective
    include Canvas::Base
    include HTTParty

    base_uri ENV["CANVAS_HOST"] + "/api/v1"

    def self.all(course_id)
      JSON.parse get("/courses/#{course_id}/modules", base_options).body
    end

    def self.find(course_id, id)
      JSON.parse get("/courses/#{course_id}/modules/#{id}", base_options).body
    end

    def self.create(course_id, le_params)
      @le_body = {
        'course_id': course_id,
        'module[name]': le_params.fetch(:name, ""),
        'module[unlock_at]': le_params.fetch(:unlock_at, ""),
        'module[position]': le_params.fetch(:position, ""),
        'module[require_sequential_progress]': le_params.fetch(:require_sequential_progress, ""),
        'module[prerequisite_module_ids][]': le_params.fetch(:prerequisite_module_ids, ""),
        'module[publish_final_grade]': le_params.fetch(:publish_final_grade, ""),
      }
      options = base_options.merge!(body: @le_body)
      JSON.parse post("/courses/#{course_id}/modules/", options).body
    end

    def self.update(course_id, id, le_params)
      @le_body = {
        'id': id,
        'course_id': course_id,
        'module[name]': le_params.fetch(:name, ""),
        'module[unlock_at]': le_params.fetch(:unlock_at, ""),
        'module[position]': le_params.fetch(:position, ""),
        'module[require_sequential_progress]': le_params.fetch(:require_sequential_progress, ""),
        'module[prerequisite_module_ids][]': le_params.fetch(:prerequisite_module_ids, ""),
        'module[publish_final_grade]': le_params.fetch(:publish_final_grade, ""),
      }
      options = base_options.merge!(body: @le_body)
      JSON.parse put("/courses/#{course_id}/modules/#{id}", options).body
    end

    def self.destroy(course_id, id)
      @le_body = {
        'id': id,
        'course_id': course_id,
      }
      options = base_options.merge!(body: @le_body)
      JSON.parse delete("/courses/#{course_id}/modules/#{id}", options).body
    end
  end
end
