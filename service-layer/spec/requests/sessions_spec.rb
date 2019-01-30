require "rails_helper"

describe "Sessions" do
  include Mocks::CognitoHelper
  include Mocks::UsersHelper

  let (:uri) { "/session" }
  let (:email) { "nick.watson@claritybizsol.com" }
  let (:valid_password) { "changeME123!" }
  let (:auth_token) { SecureRandom.uuid }

  describe "POST /session" do
    it "creates a session for a valid username and password" do
      VCR.use_cassette("sessions/create_valid_session") do
        params = { email: email, password: valid_password }
        post uri, params: params
        expect(response).to be_successful
      end
    end

    context do
      before :context do
        Aws.config[:cognitoidentityprovider] = {
          stub_responses: {
            initiate_auth: sign_in_invalid_password,
          },
        }
      end
      it "returns a 403 for an invalid password" do
        VCR.turned_off do
          params = { email: email, password: "thisIsntValid" }
          stub_fetch_by_email

          post uri, params: params
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context do
      before :context do
        Aws.config[:cognitoidentityprovider] = {
          stub_responses: {
            initiate_auth: sign_in_invalid_usename,
          },
        }
      end
      it "returns a 403 with an invalid username" do
        VCR.turned_off do
          params = { email: "jack@black.com", password: valid_password }
          stub_fetch_by_email(email: params[:email])

          post uri, params: params
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end

  describe "DELETE /session" do
    context do
      before :context do
        Aws.config[:cognitoidentityprovider] = {
          stub_responses: {
            global_sign_out: stub_cognito_sign_out,
          },
        }
      end
      it "deletes a session" do
        VCR.turned_off do
          delete uri, headers: { "Authorization": auth_token }
          expect(response).to be_successful
        end
      end
    end
  end
end
