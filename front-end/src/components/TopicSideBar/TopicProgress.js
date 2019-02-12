import React, { Component } from "react";
import { Grid, Icon, Progress } from "semantic-ui-react";
import RegisterButton from "../Buttons/RegisterButton";

import { connect } from "react-redux";
import { getProgressOfLearningPath } from "../../actions/learningPathActions";

export class TopicProgress extends Component {
  componentDidMount() {
    if(this.props.isUserLoggedIn) {
      const id = this.props.course_id;
      this.props.getProgressOfLearningPath(id);
    };
  };

  getCompletedTopics() {
    if(this.props.learningPathProgressError) {
      return 0;
    } else {
      return this.props.learningPathProgress.course_progress.requirement_completed_count;
    }
  };

  getTotalTopics() {
    if(this.props.learningPathProgressError) {
      return this.props.topicsComplete;
    } else {
      return this.props.learningPathProgress.course_progress.requirement_count;
    }
  };

  renderForSessionState() {
    const { isUserLoggedIn } = this.props;
    if (isUserLoggedIn) {
      const topicsComplete = this.getCompletedTopics();
      const topicsTotal = this.getTotalTopics();
      const pathComplete = topicsComplete === topicsTotal;
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
    learningPathProgress: store.learningPath.learningPathProgress,
    learningPathProgressError: store.learningPath.learningPathProgressError,
  };
};

const mapDispatchToProps = dispatch => {
  return {
    getProgressOfLearningPath: (id) => { dispatch(getProgressOfLearningPath(id)) },
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(TopicProgress);
