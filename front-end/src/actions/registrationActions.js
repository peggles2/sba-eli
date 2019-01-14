import axios from 'axios';

export function registerUser(userData) {
  const url = process.env.REACT_APP_SERVICE_HOST + "/sign_up";

  return {
    type: 'REGISTER',
    payload: axios.post(url, userData)
  }
}

export function loginUser(userData) {
  const url = process.env.REACT_APP_SERVICE_HOST + "/session"

  return {
    type: 'LOGIN',
    payload: axios.post(url, userData)
  }
}

export function logoutUser(token) {
  console.log('logging out using token', token);
  const url = process.env.REACT_APP_SERVICE_HOST + "/session"

  return {
    type: 'LOGOUT',
    payload: axios.delete(url, {headers: {'AUTHORIZATION': token}})
  }
}