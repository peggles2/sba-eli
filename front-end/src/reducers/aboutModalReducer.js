function defaultState() {
  return {
    show: false
  }
}

export default function reducer(state=defaultState(), action) {
  switch(action.type) {
    case 'RESET':
      return defaultState();
    case 'TOGGLE_ABOUT_MODAL':
      return {
        ...state,
        show: action.payload
      } 
    default:
      break;
  };
  
  return state;
}