import RegistrationModal from '../components/RegistrationModal/RegistrationModal';

export default function reducer(state={
  open: false,
  modalType: 'signup'
}, action) {
  switch(action.type) {
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