const defaultValue = {
  userData: {
    email: '',
    password: ''
  },
  isUserLoggedIn: false
};

export default function reducer(state=defaultValue, action) {
  switch(action.type) {
    case 'LOGIN':
      return {...state, userData: {}, userLoading: true, userError: null};
    case 'LOGIN_REJECTED':
      return {...state, userData: {}, userLoading: false, userError: action.payload};
    case 'LOGIN_FULFILLED':
      return {...state, userData: action.payload.data, userLoading: false, userError: null, isUserLoggedIn: true};
    case 'LOGOUT_FULFILLED':
      return {...state, userData: {}, userLoading: false, userError: null, isUserLoggedIn: false};
    default:
      break;
  }

  return state;
}