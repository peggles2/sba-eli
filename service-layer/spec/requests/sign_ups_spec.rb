require "rails_helper"

describe "SignUps" do
  include Mocks::CognitoHelper
  include Mocks::UsersHelper

  uri = "/sign_up"
  first_name = "John"
  last_name = "Jane"
  email = "jack123@jill.com"
  password = "changeME1234!"

  describe "POST /sign_up" do
    context do
      before :context do
        Aws.config[:cognitoidentityprovider] = {
          stub_responses: {
            sign_up: sign_up_user(email),
          },
        }
      end

      it "creates a valid account" do
        VCR.turned_off do
          params = {
            first_name: first_name,
            last_name: last_name,
            email: email,
            password: password
          }
          stub_create_user
          post uri, params: params

          expect(response).to be_successful
        end
      end
    end

    it "returns unprocessable_entity if data is invalid" do
      VCR.use_cassette("sign_ups/invalid_sign_up") do
        params = {
          first_name: first_name,
          last_name: nil, # required field
          email: email,
          password: password,
        }
        post uri, params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context do
      before :context do
        Aws.config[:cognitoidentityprovider] = {
          stub_responses: {
            sign_up: sign_up_existing_user,
          },
        }
      end

      it "returns unprocessable_entity if account already exists" do
        VCR.turned_off do
          params = {
            first_name: "Nick",
            last_name: "Watson",
            email: "nick.watson@claritybizsol.com",
            password: password
          }
          post uri, params: params
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
