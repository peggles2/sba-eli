json.access_token @cognito_response.authentication_result.access_token
json.expires_in @cognito_response.authentication_result.expires_in
json.refresh_token @cognito_response.authentication_result.refresh_token
json.user do
  json.id Current.user.id
  json.name Current.user.name
  json.sortable_name Current.user.sortable_name
  json.short_name Current.user.short_name
  json.login_id Current.user.login_id
end
