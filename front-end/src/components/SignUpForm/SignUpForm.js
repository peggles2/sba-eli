import React from 'react';
import axios from 'axios';
import {Button, Input, Container, Form, Radio} from 'semantic-ui-react';

class SignUpForm extends React.Component {
  state = {
    firstName: '',
    lastName: '',
    middleName: '',
    zipCode: '',
    email: '',
    password: '',
    confirmPassword: '',
    inBusiness: null
  };

  handleFirstNameChange = (e) => {
    this.setState({firstName: e.target.value});
  }

  handleLastNameChange = (e) => {
    this.setState({lastName: e.target.value});
  }

  handleMiddleNameChange = (e) => {
    this.setState({middleName: e.target.value});
  }

  handleEmailChange = (e) => {
    this.setState({email: e.target.value});
  }

  handlePasswordChange = (e) => {
    this.setState({password: e.target.value});
  }

  handleZipCodeChange = (e) => {
    this.setState({zipCode: e.target.value});
  }

  handleInBusiness = (e) => {
    this.setState({inBusiness: e.target.value});
  }

  handleSubmit = (e) => {
    e.preventDefault();
    const url = process.env.REACT_APP_SERVICE_HOST + "/sign_up"

    axios.post(url, {
      first_name: this.state.firstName.trim(),
      last_name: this.state.lastName.trim(),
      middle_name: this.state.middleName.trim(),
      zip_code: this.state.zipCode.trim(),
      email: this.state.email.trim(),
      password: this.state.password.trim(),
      in_business: this.state.inBusiness
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
          <h2>Register</h2>
          <hr/>
          <Form.Field required>
            <label>First Name</label>
            <input placeholder="First Name"
                   onChange={this.handleFirstNameChange.bind(this)}/> <br />
          </Form.Field>
          <Form.Field required>
            <label>Last Name</label>
            <input placeholder="Last Name"
                   onChange={this.handleLastNameChange.bind(this)}/> <br />
          </Form.Field>
          <Form.Field>
            <label>Middle Name</label>
            <input placeholder="Middle Name"
                   onChange={this.handleMiddleNameChange.bind(this)}/> <br />
          </Form.Field>
          <Form.Field>
            <label>Zip Code</label>
            <input placeholder="Zip Code"
                   onChange={this.handleZipCodeChange.bind(this)}/> <br />
          </Form.Field>
          <Form.Field required>
            <label>Email Address</label>
            <input placeholder="Email"
                   onChange={this.handleEmailChange.bind(this)}/> <br />
          </Form.Field>
          <Form.Field required>
            <label>Password</label>
            <input type="password"
                   placeholder="Password"
                   onChange={this.handlePasswordChange.bind(this)}/> <br />
          </Form.Field>
          <Form.Group grouped>
            <label>Are you in business?</label>
            <Form.Field
              control='input'
              type='radio'
              label='Yes'
              value='1'
              name='inBusiness'
              onChange={this.handleInBusiness.bind(this)}
            />
            <Form.Field
              control='input'
              label='No'
              type='radio'
              value='2'
              name='inBusiness'
              onChange={this.handleInBusiness.bind(this)}
            />
          </Form.Group>
          <Button type="submit">Submit</Button>
        </Form>
      </Container>
    );
  }
}

export default SignUpForm;