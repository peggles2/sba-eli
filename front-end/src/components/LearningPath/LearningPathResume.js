import React, { Component } from "react";
import { Button, Container, Divider, Grid, Header, Image } from "semantic-ui-react";
import LearningPathProgress from "./LearningPathProgress";

import { connect } from "react-redux";
import { getProgressOfLearningPath } from "../../actions/learningPathActions";

export class LearningPathResume extends Component {
  componentDidMount() {
    const id = this.props.learningPathId
    this.props.getProgressOfLearningPath(id);
  };

  componentDidUpdate(prevProps) {
    const prevId = prevProps.learningPathId;
    const nextId = this.props.learningPathId;

    if(prevId !== nextId) {
      const id = this.props.learningPathId;
      this.props.getProgressOfLearningPath(id);
    };
  };

  learningPathProgress = () => {
    let complete = 0;
    let total = 0;

    const courseProgress = this.props.learningPathProgress.course_progress;

    if(typeof courseProgress !== "undefined") {
      complete = courseProgress.requirement_completed_count;
      total = courseProgress.requirement_count;
    };

    return (
      <LearningPathProgress complete={complete} total={total} />
    );
  }

  render () {
    const learningPathImage = `/Image_Placeholder.png`;
    const learningPathHeader = this.props.learningPathProgress.name;
    const learningPathDescription = "Maybe it means something more - something we can't yet understand."

    return (
      <Container>
        <Grid>
          <Grid.Row>
            <Grid.Column>
              <Header as='h2'>Let's get back on your journey!</Header>
              <Divider />
            </Grid.Column>
          </Grid.Row>
          <Grid.Row className="learning-path-resume">
            <Grid.Column width={5} className="learning-path-resume-image">
              <Image size="large" src={learningPathImage} />
            </Grid.Column>
            <Grid.Column width={10} className="learning-path-resume-content">
              <Header as='h2'>{learningPathHeader}</Header>
              <p>{learningPathDescription}</p>
              { this.learningPathProgress() }
              <Divider />
              <Button
                primary
                style={{ float: "right" }}
                href={"/learning_paths/" + this.props.learningPathId}
              >
                Resume
              </Button>
            </Grid.Column>
          </Grid.Row>
        </Grid>
      </Container>
    );
  };
};

const mapStateToProps = store => {
  return {
    isUserLoggedIn: store.login.isUserLoggedIn,
    learningPathProgress: store.learningPath.learningPathProgress,
  };
};

const mapDispatchToProps = dispatch => {
  return {
    getProgressOfLearningPath: (id) => { dispatch(getProgressOfLearningPath(id)) },
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(LearningPathResume);
