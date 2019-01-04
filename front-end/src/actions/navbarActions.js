export function toggleLogin(show) {
  return {
    type: 'TOGGLE_LOGIN_MODAL',
    payload: show
  };
}

export function toggleRegister(show) {
  return {
    type: 'TOGGLE_REGISTER_MODAL',
    payload: show
  }
}