export default function axiosConfig(state, params = null, overrideAuth = false) {
  let authConfig = {};
  if (state.login.isUserLoggedIn && !overrideAuth) {
    const { access_token } = state.login.userData;
    authConfig = { headers: { AUTHORIZATION: access_token } };
  }

  return {
    params: params,
    baseURL: process.env.REACT_APP_SERVICE_HOST,
    ...authConfig
  };
}