import React from 'react';
import PropTypes from 'prop-types';
import {Modal} from 'semantic-ui-react';
import LoginForm from '../LoginForm/LoginForm';
import SignUpForm from '../SignUpForm/SignUpForm';
import RegistrationComplete from './RegistrationComplete';
import {toggleLogin, toggleRegister} from '../../actions/navbarActions';
import {connect} from "react-redux";
import { withRouter } from 'react-router-dom';

class RegistrationModal extends React.Component {
  constructor(props) {
    super(props);

    this.state = { open: props.open, type: props.type };
  }

  close = () => {
    this.props.dispatch(toggleLogin(false));
    this.props.dispatch(toggleRegister(false));
  }

  render() {
    return <Modal open={this.props.open} 
                  closeOnDimmerClick={false} 
                  closeIcon 
                  onClose={this.close}
                  size={'mini'}>
      <Modal.Content>
        {this.getModalContent(this.props.type)}
      </Modal.Content>
    </Modal>
  }

  getModalContent(type) {
    switch(type) {
      case types.signup:
        return <SignUpForm/>;
      case types.login:
        return <LoginForm/>;
      case types.success:
        return <RegistrationComplete/>
      default:
        break;
    }
  }
}

const types = {
  signup: 'signup',
  login: 'login',
  success: 'success'
}

RegistrationModal.propTypes = { type: PropTypes.oneOf(Object.keys(types)) }
RegistrationModal.types = types;

export default connect((store) => {
  return {}
})(withRouter(RegistrationModal));