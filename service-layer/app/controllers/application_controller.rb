class ApplicationController < ActionController::Base
  include SecurityConcern
  skip_before_action :verify_authenticity_token

  def render_error(resource, status)
    render json: resource.to_json, status: status
  end

  def errors_for(object)
    { json: { errors: object.errors }, status: :unprocessable_entity }
  end
end
