import RegistrationModal from '../components/RegistrationModal/RegistrationModal';

function defaultState() {
  return {
    open: false,
    modalType: 'signup'
  }
}

export default function reducer(state=defaultState(), action) {
  switch(action.type) {
    case 'RESET':
      return defaultState();
    case 'TOGGLE_LOGIN_MODAL':
      return {
        ...state,
        open: action.payload,
        modalType: RegistrationModal.types.login
      } 
    case 'TOGGLE_REGISTER_MODAL':
      return {
        ...state,
        open: action.payload,
        modalType: RegistrationModal.types.signup
      }
    case 'REGISTER_FULFILLED':
      return {
        ...state,
        open: true,
        modalType: RegistrationModal.types.success
      }
    case 'LOGIN_FULFILLED':
      return {
        ...state,
        open: false,
        modalType: RegistrationModal.types.login
      }
    default:
      break;
  };
  
  return state;
}