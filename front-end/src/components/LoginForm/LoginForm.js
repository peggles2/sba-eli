import React from 'react';
import {Button, Input, Container, Form} from 'semantic-ui-react';
import { loginUser } from '../../actions/registrationActions';
import { connect } from "react-redux";
import { withRouter } from 'react-router-dom';

class LoginForm extends React.Component {
  state = {
    email: '',
    password: ''
  };

  handleEmailChange = (e) => {
    this.setState({email: e.target.value});
  }

  handlePasswordChange = (e) => {
    this.setState({password: e.target.value});
  }

  handleSubmit = (e) => {
    e.preventDefault();

    this.props.dispatch(loginUser({
      email: this.state.email,
      password: this.state.password
    }));
  }

  render() {
    return (
      <Container>
        <Form onSubmit={this.handleSubmit.bind(this)}>
          <Form.Field>
            <Input type="text"
                   value={this.state.email}
                   placeholder="Email"
                   onChange={this.handleEmailChange.bind(this)}/> <br />
          </Form.Field>
          <Form.Field>
            <Input type="password"
                   value={this.state.password}
                   placeholder="Password"
                   onChange={this.handlePasswordChange.bind(this)}/><br />
          </Form.Field>
          <Button type="submit">Submit</Button>
        </Form>
      </Container>
    );
  }
}

export default connect((store) => {
  return {
    email: store.registration.userData.email,
    password: store.registration.userData.password
  }
})(withRouter(LoginForm));