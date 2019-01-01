import React from 'react';
import axios from 'axios';
import {Modal, Button} from 'semantic-ui-react';
import LoginForm from './LoginForm';

class LoginModal extends React.Component {
  constructor(props) {
    super(props);

    this.state = { open: props.open };
  }

  close = () => {
    this.setState({ open: false });
  }

  open = () => {
    this.setState({ open: true });
  }

  render() {
    return <Modal trigger={<Button onClick={this.open}>Login</Button>}
                  open={this.state.open} 
                  closeOnDimmerClick={false} 
                  closeIcon 
                  onClose={this.close}>
      <Modal.Content>
        <LoginForm/>
      </Modal.Content>
    </Modal>
  }
}

export default LoginModal