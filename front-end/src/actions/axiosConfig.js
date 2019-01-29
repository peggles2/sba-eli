const baseUrl = process.env.REACT_APP_SERVICE_HOST;

export default function axiosConfigForUser(state, params = null) {
  let authConfig = {};
  if (state.login.isUserLoggedIn) {
    const { access_token } = state.login.userData;
    authConfig = { headers: { AUTHORIZATION: access_token } };
  }

  return {
    params: params,
    baseURL: baseUrl,
    ...authConfig
  };
}

export function axiosConfigForAdmin(params = null) {
  return {
    params: params,
    baseURL: baseUrl
  };
}
