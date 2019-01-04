import React, { Component } from "react";
import { withRouter } from "react-router-dom";
import { Button, Divider, Grid, Header, Image } from "semantic-ui-react";
import { connect } from "react-redux";

class DashboardCTA extends Component {
  setRedirect = () => {
    return this.props.history.push("/learning_paths");
  }

  render() {
    return (
      <div className="dashboard-cta">
        <Image 
          src={`/Image_Placeholder.png`} 
          circular 
          centered
          size="medium"
          alt="img placeholder"
        />
        <Divider hidden/>
        <Grid centered>
          <Grid.Row> 
            <Header as="h2" className="dashboard-header">Take Your First Step!</Header> 
          </Grid.Row>
          <Grid.Row>
            <p>
              The journey of a thousand miles starts with a <br />
              single step. What would you like to learn today?
            </p>
          </Grid.Row>
          <Grid.Row>
            <Button primary onClick={this.setRedirect}>Find Your Path</Button>
          </Grid.Row>
        </Grid>
      </div>
    )
  }
}

export default connect((store) => {
  return {}
})(withRouter(DashboardCTA));
