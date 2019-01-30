import React, { Component } from "react";
import "./LearningEventPageContent.scss";

import { completeLearningEvent } from "../../actions/learningEventActions";
import { withRouter } from "react-router-dom";
import { connect } from "react-redux";

export class LearningEventPage extends Component {
  componentDidMount() {
    this.completeEvent();
  }

  componentDidUpdate(prevProps) {
    if (this.props.event !== prevProps.event) {
      this.completeEvent();
    }
  }

  completeEvent() {
    const { isUserLoggedIn, event } = this.props;
    if (isUserLoggedIn && !event.completion_requirement.completed) {
      const { id: path_id, topicId: objective_id } = this.props.match.params;

      this.props.dispatch(
        completeLearningEvent(path_id, objective_id, event.id)
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

const mapStateToProps = store => {
  return { isUserLoggedIn: store.login.isUserLoggedIn };
};

export default withRouter(connect(mapStateToProps)(LearningEventPage));
