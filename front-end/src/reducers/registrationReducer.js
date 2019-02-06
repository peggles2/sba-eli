function defaultState() {
  return {
    userData: {
      first_name: '',
      middle_name: '',
      last_name: '',
      zip_code: '',
      email: '',
      in_business: '',
      password: '',
      errors: {}
    }
  }
}

export default function reducer(state=defaultState(), action) {
  switch(action.type) {
    case 'RESET':
      return defaultState();
    case 'REGISTER':
      return {...state, userData: {}, userLoading: true, userError: null};
    case 'REGISTER_REJECTED':
      return {...state, userData: action.payload.response.data, userLoading: false, userError: action.payload};
    case 'REGISTER_FULFILLED':
      return {...state, userData: action.payload.data, userLoading: false, userError: null};
    default:
      break;
  }

  return state;
}