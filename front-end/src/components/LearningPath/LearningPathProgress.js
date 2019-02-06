import React, { Component } from "react";
import { Grid, Progress } from "semantic-ui-react";

class LearningPathProgress extends Component {

  progressPercent = (complete, total) => {
    return (complete / total) * 100;
  }

  eventsCompleted = ( complete, total ) => {
    return complete + ` out of ` + total + ` done!`;
  }

  render() {
    const complete = this.props.complete;
    const total = this.props.total;

    return (
      <Grid className="learning-path-progress">
        <Grid.Row className="learning-path-progress-bar-row">
          <Grid.Column>
            <Progress
              color="blue"
              size="tiny"
              percent={this.progressPercent(complete, total)}
              className="learning-path-progress-bar"
            />
          </Grid.Column>
        </Grid.Row>
        <Grid.Row className="learning-path-completed-row">
          <Grid.Column>
            <span>{ this.eventsCompleted(complete, total) }</span>
          </Grid.Column>
        </Grid.Row>
      </Grid>
    )
  }
}

export default LearningPathProgress;
