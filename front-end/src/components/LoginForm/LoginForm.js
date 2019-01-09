import React from 'react';
import {Button, Input, Container, Form, Message} from 'semantic-ui-react';
import { loginUser } from '../../actions/registrationActions';
import { connect } from "react-redux";
import { withRouter } from 'react-router-dom';
import "./LoginForm.scss";

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

  componentDidUpdate(prevProps) {
    console.log('props updated', this.props);
  }

  render() {
    return (
      <Container>
        <Message negative className={this.props.userError ? '' : 'noError'}
                       content={'Login failed. Please try again.'}></Message>
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
    email: store.login.userData.email,
    password: store.login.userData.password,
    userError: store.login.userError
  }
})(withRouter(LoginForm));