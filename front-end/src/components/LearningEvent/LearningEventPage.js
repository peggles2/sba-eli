import React, { Component } from "react";

import { completeLearningEvent } from "../../actions/learningEventActions";
import { withRouter } from "react-router-dom";
import { connect } from "react-redux";

class LearningEventPage extends Component {
  componentDidMount() {
    this.completeEvent();
  }

  componentDidUpdate(prevProps) {
    if (this.props.event !== prevProps.event) {
      this.completeEvent();
    }
  }

  completeEvent() {
    const isLoggedIn = true;
    if (isLoggedIn && !this.props.event.completion_requirement.completed) {
      const {
        id: path_id,
        topicId: objective_id,
        eventId: event_id
      } = this.props.match.params;

      this.props.dispatch(
        completeLearningEvent(path_id, objective_id, event_id)
      );
    }
  }

  render() {
    const __html = this.props.event.eventContent.body;

    return (
      <div
        className="learning-event-body"
        dangerouslySetInnerHTML={{
          __html: __html
        }}
      />
    );
  }
}

export default withRouter(connect()(LearningEventPage));
