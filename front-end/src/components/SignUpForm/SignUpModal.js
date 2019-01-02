import React from 'react';
import axios from 'axios';
import {Modal, Button} from 'semantic-ui-react';
import SignUpForm from './SignUpForm';

class SignUpModal extends React.Component {
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
    return <Modal trigger={<Button onClick={this.open}>Register</Button>}
                  open={this.state.open} 
                  closeOnDimmerClick={false} 
                  closeIcon 
                  onClose={this.close}>
      <Modal.Content>
        <SignUpForm/>
      </Modal.Content>
    </Modal>
  }
}

export default SignUpModal