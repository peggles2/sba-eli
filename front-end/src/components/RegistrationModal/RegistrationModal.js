import React from 'react';
import axios from 'axios';
import PropTypes from 'prop-types';
import {Modal, Button} from 'semantic-ui-react';
import LoginForm from '../LoginForm/LoginForm';
import SignUpForm from '../SignUpForm/SignUpForm';

class RegistrationModal extends React.Component {
  constructor(props) {
    super(props);

    this.state = { open: props.open, type: props.type };
  }

  render() {
    console.log('registration modal render', this);
    return <Modal open={this.props.open} 
                  closeOnDimmerClick={false} 
                  closeIcon 
                  onClose={this.close}>
      <Modal.Content>
        {this.getModalContent(this.props.type)}
      </Modal.Content>
    </Modal>
  }

  getModalContent(type) {
    switch(type) {
      case types.signup:
        console.log('rendering signup form');
        return <SignUpForm/>;
        break;
      case types.login:
        return <LoginForm/>;
        break;
      case types.success:
        break;
    }
  }
}

const types = {
  signup: 'signup',
  login: 'login'
}

RegistrationModal.propTypes = { type: PropTypes.oneOf(Object.keys(types)) }
RegistrationModal.types = types;

export default RegistrationModal