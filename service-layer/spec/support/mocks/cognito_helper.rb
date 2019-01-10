module Mocks
  module CognitoHelper
    include JSONFixtures

    def stub_cognito_invalid_session(*)
      url = "https://cognito-idp.#{ENV['AWS_REGION']}.amazonaws.com/"
      response_body = {
        "__type": "NotAuthorizedException",
        "message": "Incorrect username or password.",
      }.to_json

      stub_request(:post, url).to_return(status: 400, body: response_body)
    end

    def stub_cognito_signup(options = {})
      url = "https://cognito-idp.#{ENV['AWS_REGION']}.amazonaws.com/"
      status = options.fetch(:status, 200)
      response_body = options.fetch(:response_body, json_string("users/create_user.json"))

      stub_request(:post, url).to_return(status: status, body: response_body)
    end

    def sign_up_user(email)
      details = Aws::CognitoIdentityProvider::Types::CodeDeliveryDetailsType.new(
        destination: email,
        delivery_medium: "EMAIL",
        attribute_name: "email",
      )
      Aws::CognitoIdentityProvider::Types::SignUpResponse.new(
        code_delivery_details: details,
        user_confirmed: false,
        user_sub: SecureRandom.uuid,
      )
    end

    def sign_in_response
      # rubocop:disable Metrics/LineLength
      authentication_result = Aws::CognitoIdentityProvider::Types::AuthenticationResultType.new(
        "access_token": "eyJraWQiOiJwK1dzc3V3aStOdVVETUc0M05aNE45OVNCNDZcL3czYlU4SWxJMFZESXcrdz0iLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI2MDY2MmI2OC0zMWU5LTQ1MzctOWYwMi0xMDVjOTYyNTBjMWQiLCJldmVudF9pZCI6IjJkYThlZjI0LWU5ZDItMTFlOC1hMDhiLWZmYWUyYjE0ODU2ZiIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoiYXdzLmNvZ25pdG8uc2lnbmluLnVzZXIuYWRtaW4iLCJhdXRoX3RpbWUiOjE1NDIzOTQ5NTUsImlzcyI6Imh0dHBzOlwvXC9jb2duaXRvLWlkcC51cy1lYXN0LTEuYW1hem9uYXdzLmNvbVwvdXMtZWFzdC0xX0I4TGxmVFU3VyIsImV4cCI6MTU0MjM5ODU1NSwiaWF0IjoxNTQyMzk0OTU1LCJqdGkiOiI5ODI1MzllMy1iMmI3LTQwOWMtODNlOC0yYmNlNGQzYWU1ZjAiLCJjbGllbnRfaWQiOiI3NmpjcTMzN2FlaTI3dmE5cTlndGFlcDBkaCIsInVzZXJuYW1lIjoibmljay53YXRzb25AY2xhcml0eWJpenNvbC5jb20ifQ.Jd9LWnIy2_YBCZRBt90zjRDemxKTE_SUPkxwxrzWa7Rdkdrm1PtS_mDWgHSJsf0VDV7tWAMJGloUPb-dJLlkdst8aVH5Ohb8RFDZ7kZsFcVpcuMMNxOwj9JQN-7AlqBLvR3B49G1kD2_TlxdYO0BtNH5GxtwCd_SNLTfp_EBPgrLfA4WrKJCHm__2j0CHzCFg-WJGc2cjwkcsqz_JO6wtMKR0WiqVeYr9IWUNNyv_cEbZTKB_5etbaB5KYHXE7uklo3BOZdRqwmNqpOdO97ieSAb7cpAd6F75411eaeTRUgASg5oOVlQe9wzl9V2s76oY1lcXI_yfgRinFMrkxqC_A",
        "expires_in": 3600,
        "id_token": "eyJraWQiOiI3ZWFqVHR6RjVZeU5nZkQ0VzkxM1l5a1pFQWxuakt4djBEbzFCZmxJR3N3PSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI2MDY2MmI2OC0zMWU5LTQ1MzctOWYwMi0xMDVjOTYyNTBjMWQiLCJhdWQiOiI3NmpjcTMzN2FlaTI3dmE5cTlndGFlcDBkaCIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJldmVudF9pZCI6IjJkYThlZjI0LWU5ZDItMTFlOC1hMDhiLWZmYWUyYjE0ODU2ZiIsInRva2VuX3VzZSI6ImlkIiwiYXV0aF90aW1lIjoxNTQyMzk0OTU1LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAudXMtZWFzdC0xLmFtYXpvbmF3cy5jb21cL3VzLWVhc3QtMV9COExsZlRVN1ciLCJjb2duaXRvOnVzZXJuYW1lIjoibmljay53YXRzb25AY2xhcml0eWJpenNvbC5jb20iLCJleHAiOjE1NDIzOTg1NTUsImlhdCI6MTU0MjM5NDk1NSwiZW1haWwiOiJuaWNrLndhdHNvbkBjbGFyaXR5Yml6c29sLmNvbSJ9.PNoeTPLuf_e42DHdmswuzCvifAxQiUEPBHyhwRq82Tg0xNQ97VCp8CyYB8jmR91MsgGfGNxm0CaLNNLTUnPxB6pt2407NxNl_0eDP5QoT1pU8DWUrRSWylCYQd57xLsNhsM9sotY-wn6vNAnOL6viQXxQEHK55NM4TO5xo41dulpTZlmEoBbhSNaHUE4vhAqH_DifaZ2RIe_XyvAfbstEoaFT8ZLbpaMegEI5Uwp7EWwSiS_ZuoAZz5hOutQEQrOJ9flesEmBAYmcZKP2RNan3D8SRwooTBJI7lpX1BRQMh62aJP3Stn9H-B8jkCIK9lx2_APU79RHrdCEu-lPtqDQ",
        "refresh_token": "eyJjdHkiOiJKV1QiLCJlbmMiOiJBMjU2R0NNIiwiYWxnIjoiUlNBLU9BRVAifQ.dLBJ821sa8j-7dLjrt75Y-e60l-YzDOCzZ0nGEflRxiF3qyFERyUIt0Wf_59dhb9yK3UDkdhE1y55AVDbkxGq8eCQrX7beewMNha5aMqDz_ThpvZxEmthcwjcekxro6_UQ2A9qHcsibYAwC3QfULX8JgYb46iam5IpChKkR03Uc01_7IzobEhjXWYiAsxX2pENtPiW0Br4yBE1JftNa52Zk-KZFjsg4hx7zePLmHOBIG7IwJrx1VvIe6r9SWt6X5TjXa9H6xcXBawOwIDT0LE3-WHYm_oJ_0ze_r9jUyW8YdfRNAW487bpmh_ScOBqzBDTIszKnGMAxZ3br_S3oGnA.A4hEgaq60diw9ymv.CBRRZTuklBVBE3lUGdS9EjnOpg5rMsZtLnZEp_6okC0x-8SGXRrau0ok6auVYXHd-j8s3ys-A2nXy3DIzGvytiarJKr1hWTpjUfZeWX4vtu5zWG5CkSrY_RJjZNi8n67kUcPmKQWELg4u3wgjIn8e8w4-DWCjJXzzfscVtWmyoTbFkwC0KZ92pdWoajQOBN9L8JqZlVMQSFoPj2_t2ZKNsfnUuXUfsFZQnzaS_4MT0v3md0MIshAQ4WOIcXeV27kwgtWDzAlvxgML9XWERiSvf0MEA2sa1kYC1F0hvAcz1Clu9ACrxclhwnfLKSq2VqYTWKg29JrfyghVaJ_BbkSRvtNsJRXdGmDwhbk1PzFssuYhD1QXJv3d6arergN62-X1Rv97MCE_FadGBhEd7WLCj08SOMfg7bdruwgNo9JoL80owZ-DoCrl9c-SiSjjBTd4mq8P1lLuUghqvapBumS0OylViBX3Hgxj5zugTGzEPneEgiTZQQKviQwFrNNpfUYFcUrA-7h46lYuT3523GOLKT9TxTRMjW_a2itkswrzrPh5uBHk-VUAfXwB_7pr-dvoU7mcTQSTQcZpFBcWtq21RkN8uRFDimSDPqkRVkDC9m-UYoBNQFp5J-25k2VXvS9xl94pwc1BbiE36umk5WAhi3JaJaoB9l1fGrMLGNGDqRW0Ca7_-wDf1YmAcAorM1K9BlXedo_nH5lAwTOGckHTVAORPPrVpwt-vbTetMfqn10C0DWm7rD16U-Qa7eIHIJoBNaKtaJ79hDJyvW-S4TZmePwN-Hb0wiu28PuwRP-kXlYFKF7IwujNCuQM9GsNjTVAxrO8lZg5OBMQXqLLnTh1odtZ0-VWnNPeGHMktF3NrtK83eK70QOj9bgZM9ZReNP-u75qWiGRaYJ0KI5UlRQf-pjhr2eQghpdt44I8LT3p3GNkloMcE7nrpdaM9wlxEICzle_h-CnFA_nnpXYx7XyxSgWbbiDDGHhTsOsROr73q9HKTh-5ozAsFOK7ozEhKyOT436Pfaui7hwytiO94mB9sa11eZK_PJYzeFAWejFzAp7NBh-x9rcxYeSwdoAwMaDP8ELr2yyabwnpIygG5Yi01pL5t54o6hI1CIle72wrfcMNPuUbD0LhRW0dvXbaHLBon-II5jxWLJCgvTUWIQV43ICK8MgEWKIrsVM6SDQGEmqh4g_903GQO1FkFBHxVIIf59m5tVjuBEosAOdIw-ne5lk2UBo277CJbnsGwOK0QJU7TvZpOUCBx3Bjdh_BTM9W9gP91N3XawAWu3xY3R1XUE-z6w8RjeiiE6_YtySm6yw.u8oVCXi_n24Rmhs007pi2Q",
        "token_type": "Bearer",
      )
      # rubocop:enable Metrics/LineLength
      Aws::CognitoIdentityProvider::Types::InitiateAuthResponse.new(
        authentication_result: authentication_result,
        challenge_parameters: {},
      )
    end

    def sign_up_existing_user
      Proc.new do
        Aws::CognitoIdentityProvider::Errors.error_class(
          "UsernameExistsException",
        ).new("username", "username")
      end
    end

    def sign_in_invalid_usename
      Proc.new do
        Aws::CognitoIdentityProvider::Errors::UserNotFoundException.new("username", "username")
      end
    end

    def sign_in_invalid_password
      Proc.new do
        Aws::CognitoIdentityProvider::Errors::NotAuthorizedException.new("username", "username")
      end
    end

    def forgot_password_response(email)
      Proc.new do
        code_delivery_details = Aws::CognitoIdentityProvider::Types::CodeDeliveryDetailsType.new(
          destination: email,
          delivery_medium: "EMAIL",
          attribute_name: "email",
        )
        Aws::CognitoIdentityProvider::Types::ForgotPasswordResponse.new(
          code_delivery_details: code_delivery_details,
        )
      end
    end

    def confirm_forgot_password
      Proc.new do
        Seahorse::Client::Response.new(status_code: 200)
      end
    end

    def get_user_response(options = {})
      email = options.fetch(:email, "jane.doe@example.com")
      sub = options.fetch(:sub, SecureRandom.uuid)
      email_verified = options.fetch(:email_verified, true)

      Proc.new do
        user_attributes = Array.new
        user_attributes.push Aws::CognitoIdentityProvider::Types::AttributeType.new(
          name: "sub",
          value: sub,
        )
        user_attributes.push Aws::CognitoIdentityProvider::Types::AttributeType.new(
          name: "email_verified",
          value: email_verified,
        )
        user_attributes.push Aws::CognitoIdentityProvider::Types::AttributeType.new(
          name: "email",
          value: email,
        )
        Aws::CognitoIdentityProvider::Types::GetUserResponse.new(
          username: email,
          user_attributes: user_attributes,
        )
      end
    end
  end
end
