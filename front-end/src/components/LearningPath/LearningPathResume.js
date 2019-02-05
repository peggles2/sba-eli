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

  render () {
    const learningPathImage = `/Image_Placeholder.png`;
    const learningPathHeader = this.props.learningPathProgress.name;
    const learningPathDescription = "Maybe it means something more - something we can't yet understand."
    const complete = this.props.learningPathProgress.course_progress.requirement_completed_count;
    const total = this.props.learningPathProgress.course_progress.requirement_count;

    return(
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
              <LearningPathProgress complete={complete} total={total} />
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
    learningPathProgress: store.learningPath.learningPathProgress,
  };
};

const mapDispatchToProps = dispatch => {
  return {
    getProgressOfLearningPath: (id) => { dispatch(getProgressOfLearningPath(id)) },
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(LearningPathResume);
