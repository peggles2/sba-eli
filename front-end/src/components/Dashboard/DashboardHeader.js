import React, { Component } from "react";
import { Divider, Grid, Header } from "semantic-ui-react";

export default class DashboardHeader extends Component {
  render() {
    const title = "My Dashboard";

    return (
      <Grid>
        <Grid.Row>
          <Grid.Column mobile={15} tablet={15} computer={15}>
            <Header as="h1" className="dashboard-header">{title}</Header>
            <Divider />
          </Grid.Column>
        </Grid.Row>
      </Grid>
    );
  }
};
