module CognitoService
  def self.client
    Aws::CognitoIdentityProvider::Client.new(
      region: ENV["AWS_REGION"],
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    )
  end

  def self.sign_up(email, password)
    client.sign_up(
      client_id: ENV["AWS_COGNITO_CLIENT_ID"],
      username: email,
      password: password,
      user_attributes: [
        {
          name: "email",
          value: email,
        },
      ],
    )
  end

  def self.authenticate(email, password)
    client.initiate_auth(
      client_id: ENV["AWS_COGNITO_CLIENT_ID"],

      auth_flow: "USER_PASSWORD_AUTH",
      auth_parameters: {
        "USERNAME" => email,
        "PASSWORD" => password,
      },
    )
  end

  def self.confirm_sign_up(email, code)
    client.confirm_sign_up(
      client_id: ENV["AWS_COGNITO_CLIENT_ID"],
      username: email,
      confirmation_code: code,
    )
  end

  def self.get_user(access_token)
    client.get_user(access_token: access_token)
  end

  def self.forgot_password(email)
    client.forgot_password(
      client_id: ENV["AWS_COGNITO_CLIENT_ID"],
      username: email,
    )
  end

  def self.confirm_forgot_password(email, confirmation_code, password)
    client.confirm_forgot_password(
      client_id: ENV["AWS_COGNITO_CLIENT_ID"],
      username: email,
      confirmation_code: confirmation_code,
      password: password,
    )
  end

  def self.change_password(previous_password, proposed_password, access_token)
    client.change_password(
      previous_password: previous_password,
      proposed_password: proposed_password,
      access_token: access_token,
    )
  end

  def self.sign_out(access_token)
    client.global_sign_out(
      access_token: access_token,
    )
  end
end
