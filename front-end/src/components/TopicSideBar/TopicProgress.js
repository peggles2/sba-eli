import React, { Component } from "react";
import { Grid, Icon, Progress } from "semantic-ui-react";
import RegisterButton from "../Buttons/RegisterButton";

import { connect } from "react-redux";

export class TopicProgress extends Component {

  renderForSessionState() {
    const { isUserLoggedIn } = this.props;
    if (isUserLoggedIn) {
      const { topicsComplete, topicsTotal } = this.props;
      const pathComplete = topicsComplete === topicsTotal;
      if (pathComplete) {
        //display "you completed your journey!"
        return (
          <Grid.Row>
            <Grid.Column className="topic-progress-finished">
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
            <Grid.Column className="topic-progress-track-row" textAlign={"center"}>
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
              <RegisterButton />
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
  };
};

const mapStateToProps = store => {
  return {
    isUserLoggedIn: store.login.isUserLoggedIn,
  };
};

export default connect(mapStateToProps)(TopicProgress);
