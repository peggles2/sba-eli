const defaultValue = {
  userData: {
    email: '',
    password: ''
  }
};

export default function reducer(state=defaultValue, action) {
  switch(action.type) {
    case 'LOGIN':
      return {...state, userData: {}, userLoading: true, userError: null};
    case 'LOGIN_FAILURE':
      return {...state, userData: {}, userLoading: false, userError: action.payload};
    case 'LOGIN_FULFILLED':
      return {...state, userData: action.payload.data, userLoading: false, userError: null};
    default:
      break;
  }

  return state;
}