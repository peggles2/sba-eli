import React from 'react';

export default function reducer(state={
  showLogin: false,
  showRegister: false
}, action) {
  switch(action.type) {
    case 'TOGGLE_LOGIN_MODAL':
      return {
        ...state,
        show: action.payload
      } 
    default:
      break;
  };
  
  return state;
}