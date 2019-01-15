import React from 'react';
import {Button, Input, Container, Form, Message, Grid} from 'semantic-ui-react';
import { loginUser } from '../../actions/registrationActions';
import { toggleRegister } from '../../actions/navbarActions'
import { connect } from "react-redux";
import { withRouter } from 'react-router-dom';
import "./LoginForm.scss";

export class LoginForm extends React.Component {
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

  getErrorMessageIfNeeded() {
    if (this.props.userError) {
      return <Message negative content={'Login failed. Please try again.'}></Message>
    }
  }

  render() {
    return (
      <Container>
        {this.getErrorMessageIfNeeded()}
        <Form onSubmit={this.handleSubmit.bind(this)}>
          <Form.Field>
            <label>Email:</label>
            <Input type="text"
                   value={this.state.email}
                   placeholder="Email"
                   onChange={this.handleEmailChange.bind(this)}/> <br />
          </Form.Field>
          <Form.Field>
            <label>Password:</label>
            <Input type="password"
                   value={this.state.password}
                   placeholder="Password"
                   onChange={this.handlePasswordChange.bind(this)}/><br />
          </Form.Field>
          <Grid centered>
            <Grid.Row>
              <Grid.Column width={4}>
                <Button className="submit" type="submit">Sign In</Button>
              </Grid.Column>
            </Grid.Row>
            <Grid.Row>
              <Grid.Column width={4}>
                <hr/>
              </Grid.Column>
              <Grid.Column className='orText' width={2}>
                OR
              </Grid.Column>
              <Grid.Column width={4}>
                <hr/>
              </Grid.Column>
            </Grid.Row>
            <Grid.Row>
              <Grid.Column width={6}>
                <b>Don't have an account?</b>
              </Grid.Column>
            </Grid.Row>
            <Grid.Row>
              <Grid.Column width={4}>
                <Button className="switchToRegister" onClick={() => {this.props.dispatch(toggleRegister(true))}}>Register</Button>
              </Grid.Column>
            </Grid.Row>
          </Grid>
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