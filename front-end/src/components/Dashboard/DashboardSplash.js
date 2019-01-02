import React, { Component } from "react";
import { withRouter } from 'react-router-dom';
import { Grid, Header, Button } from "semantic-ui-react";
import { connect } from "react-redux";

import { toggleModal } from '../../actions/aboutModalActions'

class DashboardSplash extends Component {
  render() {
    return (
      <Grid centered>
        <Grid.Row>
          <Grid.Column mobile={16} tablet={8} computer={8} textAlign="center">
            <Header as="h1">Awesome Hero Caption</Header>
          </Grid.Column>
        </Grid.Row>
        <Grid.Row style={{ fontWeight: "bold" }}>
          <Grid.Column mobile={16} tablet={8} computer={8} textAlign="center">
            <div>
              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam
              commodo vel est ac tempor. Proin ultricies dictum risus, et tempus
              felis blandit eget. Curabitur ac neque porttitor urna aliquet
              vestibulum nec sit amet enim. Curabitur augue enim, vulputate
              faucibus semper sed, elementum eu arcu. Maecenas id diam sem.
              Nulla dictum eros vitae porta lobortis. Nunc iaculis ullamcorper
              odio. Quisque sed rutrum diam, eget maximus nulla. Nullam sed
              dolor quam. Fusce tempus quis ligula at pharetra. Nam eget erat et
              justo tincidunt laoreet. In finibus massa magna, at pharetra nibh
              aliquam id. Duis aliquet ex sit amet nulla mattis, consequat
              mattis augue porta.
            </div>
          </Grid.Column>
        </Grid.Row>
        <Grid.Row>
          <Button size="huge" onClick={() => {
                        this.props.dispatch(toggleModal(true));
                        this.props.history.push("/learning_paths");
                      }}>Begin Your Journey</Button>
        </Grid.Row>
      </Grid>
    );
  }
}

export default connect((store) => {
  return {}
})(withRouter(DashboardSplash));
