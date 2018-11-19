import React from 'react';
import './App.css';
import {Input, Container} from 'semantic-ui-react';
var AmazonCognitoIdentity = require('amazon-cognito-identity-js');

var poolData = {
  UserPoolId : 'us-east-1_B8LlfTU7W', // Your user pool id here
  ClientId : '76jcq337aei27va9q9gtaep0dh' // Your client id here
};
 var userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);

class SignUpForm extends React.Component {
  state = {
    email: '',
    password: '',
  };

  handleEmailChange = (e) => {
    this.setState({email: e.target.value});
  }

  handlePasswordChange = (e) => {
    this.setState({password: e.target.value});
  }

  handleSubmit = (e) => {
    e.preventDefault();
    const email = this.state.email.trim();
    const password = this.state.password.trim();
    const attributeList = [
      new AmazonCognitoIdentity.CognitoUserAttribute({
        Name: 'email',
        Value: email,
      })
    ];
    userPool.signUp(email, password, attributeList, null, (err, result) => {
      if (err) {
        console.log(err);
        return;
      }
      console.log('user name is ' + result.user.getUsername());
      console.log('call result: ', result);
    });
  }

  render() {
    return (
      <Container>
        <form onSubmit={this.handleSubmit.bind(this)}>
          <Input type="text"
                 value={this.state.email}
                 placeholder="Email"
                 onChange={this.handleEmailChange.bind(this)}/> <br />
          <Input type="password"
                 value={this.state.password}
                 placeholder="Password"
                 onChange={this.handlePasswordChange.bind(this)}/><br />
          <Input type="submit"/>
        </form>
      </Container>
      
    );
  }
}

export default SignUpForm;