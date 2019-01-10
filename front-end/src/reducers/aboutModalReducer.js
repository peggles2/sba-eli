export default function reducer(state={
  show: false
}, action) {
  switch(action.type) {
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