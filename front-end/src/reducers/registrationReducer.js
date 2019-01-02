const defaultValue = {
};

export default function reducer(state=defaultValue, action) {
  switch(action.type) {
    case 'REGISTER':
      return {...state, userData: {}, userLoading: true, userError: null};
    case 'REGISTER_FAILURE':
      return {...state, userData: {}, userLoading: false, userError: action.payload};
    case 'REGISTER_FULFILLED':
      return {...state, userData: action.payload.data, userLoading: false, userError: null};
    default:
      break;
  }

  return state;
}