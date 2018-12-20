import React, { Component } from "react";
import { Grid, Icon, Progress, Button } from "semantic-ui-react";
import { Link } from "react-router-dom";

export default class TopicProgress extends Component {
  state = { isLoggedIn: true };

  renderForSessionState() {
    const { isLoggedIn } = this.state;
    if (isLoggedIn) {
      //show progress bar or completed journey
      const { topicsComplete, topicsTotal } = this.props;
      const pathComplete = topicsComplete === topicsTotal ? true : false; //Logic for path complete
      if (pathComplete) {
        //display "you completed your journey!"
        return (
          <Grid.Row>
            <Grid.Column>
              <Icon
                name="image"
                size="large"
                className={"topic-progress-icon"}
              />
              <b>Congrats!</b> You've finished your journey!
            </Grid.Column>
          </Grid.Row>
        );
      } else {
        //progress bar!
        return (
          <React.Fragment>
            <Grid.Row>
              <Grid.Column>
                <Icon
                  name="image"
                  size="large"
                  className={"topic-progress-icon"}
                />
                <b>Progress of your journey!</b>
              </Grid.Column>
            </Grid.Row>
            <Grid.Row className={"topic-progress-bar-row"}>
              <Grid.Column>
                <Progress
                  percent={this.progressPercentage(topicsComplete, topicsTotal)}
                  color={"blue"}
                  className={"topic-progress-bar"}
                />
              </Grid.Column>
            </Grid.Row>
            <Grid.Row>
              <Grid.Column>
                <div className={"topic-progress-meta"}>
                  {topicsComplete} out of {topicsTotal} done!
                </div>
              </Grid.Column>
            </Grid.Row>
          </React.Fragment>
        );
      }
    } else {
      //Show register button
      return (
        <React.Fragment>
          <Grid.Row>
            <Grid.Column textAlign={"center"}>
              <Icon
                name="image"
                size="large"
                className={"topic-progress-icon"}
              />
              <b>Track your journey!</b>
            </Grid.Column>
          </Grid.Row>
          <Grid.Row className={"topic-progress-register-row"}>
            <Grid.Column textAlign={"center"}>
              <Link to={`/signup`}>
                <Button primary>Register</Button>
              </Link>
            </Grid.Column>
          </Grid.Row>
        </React.Fragment>
      );
    }
  }

  progressPercentage(complete, total) {
    return (complete / total) * 100;
  }

  render() {
    return (
      <Grid className={"topic-progress"}>{this.renderForSessionState()}</Grid>
    );
  }
}
