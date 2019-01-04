module CognitoService
  def self.client
    Aws::CognitoIdentityProvider::Client.new(
      region: ENV["AWS_REGION"],
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    )
  end

  def self.sign_up(email, password)
    result = client.sign_up(
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
    Rails.logger.debug("signup response #{result.inspect}")
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
end
