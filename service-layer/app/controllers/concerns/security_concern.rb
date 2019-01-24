module SecurityConcern
  extend ActiveSupport::Concern

  SESSION_KEY = :id

  included do
    before_action :authenticate_request
  end

  def authenticate_request
    authenticate_request_with_token || authenticate_request_with_cookie
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
    CognitoService.sign_out(Current.access_token) if Current.access_token
  end

  def authenticate_request_with_cookie
    if session_cookie
      response = Canvas::User.read_user(session_cookie)
      Current.user = User.from_canvas_json(response)
      true
    end
  end

  def authenticate_request_with_token
    token = request.headers["HTTP_AUTHORIZATION"]
    return unless token

    begin
      cognito_response = CognitoService.get_user(token)
      user_response = Canvas::User.fetch_by_email(cognito_response[:username])
      Current.user = User.from_canvas_json(user_response)
      Current.access_token = token
      true
    rescue Aws::CognitoIdentityProvider::Errors::NotAuthorizedException
      false
    end
  end

  def valid_session?
    return_forbidden unless Current.user
  end

  def return_forbidden
    render json: { error: "Not Authorized" }, status: :unauthorized
  end
end
