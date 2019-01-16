import React from 'react';
import PropTypes from 'prop-types';
import {Modal, Grid, Button, Icon} from 'semantic-ui-react';
import LoginForm from '../LoginForm/LoginForm';
import SignUpForm from '../SignUpForm/SignUpForm';
import RegistrationComplete from './RegistrationComplete';
import {toggleLogin, toggleRegister} from '../../actions/navbarActions';
import {connect} from "react-redux";
import { withRouter } from 'react-router-dom';

import "./RegistrationModal.scss"

export class RegistrationModal extends React.Component {
  constructor(props) {
    super(props);

    this.state = { open: props.open, type: props.type };
  }

  close = () => {
    this.props.dispatch(toggleLogin(false));
    this.props.dispatch(toggleRegister(false));
  }

  render() {
    return <Modal id="registrationModal"
                  open={this.props.open}
                  closeOnDimmerClick={false} 
                  size={'tiny'}>
      <Modal.Content>
        <Grid>
          <Grid.Row stretched columns={16}>
            <Grid.Column width={14}>
              <h2>{this.getTitle(this.props.type)}</h2>
            </Grid.Column>
            <Grid.Column width={2}>
              <Button className='close-icon' icon><Icon link name='close' size='large' onClick={this.close}/></Button>
            </Grid.Column>
          </Grid.Row>
        </Grid>
        <hr/>

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

  getTitle(type) {
    switch(type) {
      case types.signup:
        return 'Register';
      case types.login:
        return 'Welcome';
      case types.success:
        return 'Register'
      default:
        return '';
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