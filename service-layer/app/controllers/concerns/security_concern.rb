module SecurityConcern
  extend ActiveSupport::Concern

  SESSION_KEY = :id

  included do
    before_action :authenticate_request
  end

  def authenticate_request
    if session_cookie
      response = Canvas::User.read_user(session_cookie)
      Current.user = User.from_canvas_json(response)
    end
  end

  def session_cookie
    session[SESSION_KEY]
  end

  def sign_in(user)
    Current.user = user
    session[SESSION_KEY] = user.id
  end

  def sign_out
    session[SESSION_KEY] = nil
  end

  def valid_session?
    return_forbidden unless Current.user
  end

  def return_forbidden
    render json: { error: "Not Authorized" }, status: :unauthorized
  end
end
