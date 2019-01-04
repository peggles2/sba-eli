import React from 'react';
import axios from 'axios';
import {Button, Input, Container, Form} from 'semantic-ui-react';

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
    const url = process.env.REACT_APP_SERVICE_HOST + "/session"

    axios.post(url, {
      email: this.state.email.trim(),
      password: this.state.password.trim()
    }).then(() => {
      console.log('Success!');
    }).catch((e) => {
      console.log('Failure!', e);
    });
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

export default LoginForm;