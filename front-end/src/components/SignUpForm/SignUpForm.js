import React from 'react';
import {Button, Container, Form, Grid, Message} from 'semantic-ui-react';
import { toggleLogin, toggleRegister } from '../../actions/navbarActions';
import { registerUser } from '../../actions/registrationActions';
import { connect } from "react-redux";
import { withRouter } from 'react-router-dom';
import "./SignUpForm.scss";

class SignUpForm extends React.Component {
  state = this.getState(this.props);

  getState(props) {
    return {
      first_name: props.first_name || '',
      last_name: props.last_name || '',
      middle_name: props.middle_name || '',
      zip_code: props.zip_code || '',
      email: props.email || '',
      password: props.password || '',
      in_business: props.in_business || '',
      errors: {}
    };
  }

  componentDidUpdate(prevProps) {
    if ((prevProps.first_name !== this.props.first_name) ||
        (prevProps.last_name !== this.props.last_name) ||
        (prevProps.middle_name !== this.props.middle_name) ||
        (prevProps.zip_code !== this.props.zip_code) ||
        (prevProps.email !== this.props.email) ||
        (prevProps.password !== this.props.password) ||
        (prevProps.in_business !== this.props.in_business) ||
        (prevProps.errors !== this.props.errors)) {
      this.setState(this.getState(prevProps));
    }
  }

  handleSubmit = (e) => {
    e.preventDefault();

    this.props.dispatch(registerUser({
      first_name: this.state.first_name.trim(),
      last_name: this.state.last_name.trim(),
      middle_name: this.state.middle_name.trim(),
      zip_code: this.state.zip_code.trim(),
      email: this.state.email.trim(),
      password: this.state.password.trim(),
      in_business: this.state.in_business
    }));
  }

  showLogin = () => {
    this.props.dispatch(toggleLogin(true));
  }

  hasError(field) {
    if (!this.props.errors[field])
      return false;
    return this.props.errors[field].length > 0;
  }

  getFieldError(field) {
    if (!this.props.errors[field])
      return '';
    return this.props.errors[field][0]
  }

  getChangeHandler(field) {
    return (e) => {
      var state = {};
      state[field] = e.target.value;
      this.setState(state);
    }
  }

  getField(field, fieldName, required) {
    return <Form.Field required={required}>
              <label>{fieldName}</label>
              <Message negative className={this.hasError(field) ? '' : 'noError'}
                       content={this.getFieldError(field)}></Message>
              <Form.Input placeholder={fieldName}
                   value={this.state[field]}
                   onChange={this.getChangeHandler(field).bind(this)}
                   error={this.hasError(field)}/>
            </Form.Field>
  }

  render() {
    return (
      <Container>
        <Form onSubmit={this.handleSubmit.bind(this)}>
          {this.getField('first_name', 'First Name', true)}
          {this.getField('last_name', 'Last Name', true)}
          {this.getField('middle_name', 'Middle Name')}
          {this.getField('zip_code', 'Zip Code')}
          {this.getField('email', 'Email', true)}
          <Form.Field required>
              <label>Password</label>
              <Message negative className={this.hasError('password') ? '' : 'noError'}
                       content={this.getFieldError('password')}></Message>
              <Form.Input placeholder="Password" type="password"
                   value={this.state.password}
                   onChange={this.getChangeHandler('password').bind(this)}
                   error={this.hasError('password')}/> <br />
          </Form.Field>
          <Form.Group grouped required>
            <label>Are you in business?</label>
            <Form.Field
              control='input'
              type='radio'
              label='Yes'
              value='1'
              name='in_business'
              onChange={this.getChangeHandler('in_business').bind(this)}
            />
            <Form.Field
              control='input'
              label='No'
              type='radio'
              value='2'
              name='in_business'
              onChange={this.getChangeHandler('in_business').bind(this)}
            />
          </Form.Group>
          <Grid>
            <Grid.Row columns={16}>
              <Grid.Column width={10}>Already have an account? <a href="/" onClick={(e) => {e.preventDefault(); this.props.dispatch(toggleLogin(true))}}>Log in</a></Grid.Column>
              <Grid.Column><Button type="submit">Submit</Button></Grid.Column>
            </Grid.Row>
          </Grid>
        </Form>
      </Container>
    );
  }
}

export default connect((store) => {
  return {
    first_name: store.registration.userData.first_name,
    last_name: store.registration.userData.last_name,
    middle_name: store.registration.userData.middle_name,
    zip_code: store.registration.userData.zip_code,
    email: store.registration.userData.email,
    password: store.registration.userData.password,
    in_business: store.registration.userData.in_business,
    errors: store.registration.userData.errors
  }
})(withRouter(SignUpForm));