import React, {Component} from "react";
import {Grid} from "semantic-ui-react";

export default class RegistrationComplete extends Component {
  render() {
    return <Grid id='registrationComplete' centered columns={16}>
            <Grid.Row stretched centered columns={4}>
              <Grid.Column>
                <img className='logo' src={`/modal-graphic-2x.png`} alt="Ascent"/>
              </Grid.Column>
            </Grid.Row>
            <Grid.Row className='success-message' centered columns={16}>
              <Grid.Column width={3}>
                <span >Congrats!</span>
              </Grid.Column>
            </Grid.Row>
            <Grid.Row className='success-message' centered columns={14}>
              <Grid.Column width={8}>
                <span>You've successfully registered!</span>
              </Grid.Column>
            </Grid.Row>
            <Grid.Row  centered columns={16}>
              <Grid.Column width={10}>
                <span>Take a look at your inbox for a confirmation email.</span>
              </Grid.Column>
            </Grid.Row>
          </Grid>
  }
}
