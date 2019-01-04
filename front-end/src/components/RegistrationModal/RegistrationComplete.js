import React, {Component} from "react";
import {Grid} from "semantic-ui-react";
import "./RegistrationModal.scss";

export default class SearchPage extends Component {
  render() {
    return <Grid centered>
            <Grid.Row>
              <Grid.Column><h2>Register</h2><hr/></Grid.Column>
            </Grid.Row>
            <Grid.Row columns={3}>
              <Grid.Column>
                <img className='logo' src={`/modal-graphic-2x.png`} alt="Ascent"/>
              </Grid.Column>
            </Grid.Row>
            <Grid.Row stretched centered columns={8}>
              <Grid.Column width={6}>
                <span className='registration-message'>Congrats!</span>
              </Grid.Column>
            </Grid.Row>
            <Grid.Row stretched centered columns={8}>
              <Grid.Column width={6}>
                <span className='registration-message'>You've successfully registered!</span>
              </Grid.Column>
            </Grid.Row>
            <Grid.Row stretched centered columns={8}>
              <Grid.Column width={6}>
                <span>Take a look at your inbox for a confirmation email.</span>
              </Grid.Column>
            </Grid.Row>
          </Grid>
  }
}