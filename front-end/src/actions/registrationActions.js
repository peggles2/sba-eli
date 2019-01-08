import axios from 'axios';

export function registerUser(userData) {
  const url = process.env.REACT_APP_SERVICE_HOST + "/sign_up";

  return {
    type: 'REGISTER',
    payload: axios.post(url, userData)
  }
}