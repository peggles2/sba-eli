import React, { Component } from "react";
import { connect } from "react-redux";
import { withRouter } from "react-router-dom";

import LearningEventHeader from "./LearningEventHeader";
import LearningEventManager from "./LearningEventManager";
import LearningEventFooter from "./LearningEventFooter";
import { Container, Divider } from "semantic-ui-react";
import "./LearningEvent.scss";
import MetaTags from "../SEO/MetaTags";
import LearningEventDiscussion from "../Discussion/LearningEventDiscussion";

import {
  getLearningEvent,
  getLearningEvents
} from "../../actions/learningEventActions";

export class LearningEvent extends Component {
  static getEventPath(course_id, module_id, event_id) {
    return (
      `/learning_paths/${course_id}` +
      `/learning_objectives/${module_id}` +
      `/learning_events/${event_id}`
    );
  }

  componentDidMount() {
    this.setLearningEvent();
  }

  componentDidUpdate(prevProps) {
    if (this.props.match !== prevProps.match) {
      this.setLearningEvent();
    }
  }

  setLearningEvent() {
    const {
      id: course_id,
      topicId: module_id,
      eventId: event_id
    } = this.props.match.params;
    this.props.dispatch(getLearningEvent(course_id, module_id, event_id));
    this.props.dispatch(getLearningEvents(course_id, module_id));
  }

  render() {
    const { learningEvent, topicTitle } = this.props;

    return (
      <div>
        <Container className="learning-event-container">
          <MetaTags
            metaTitle={learningEvent.title}
            metaDescription={learningEvent.description}
            canonicalUrl=""
          />
          <LearningEventHeader event={learningEvent} topicTitle={topicTitle} />
          <LearningEventManager event={learningEvent} />
          <Divider />
          <LearningEventFooter
            courseId={this.props.match.params.id}
            module={this.props.learningEvents}
            event={this.props.learningEvent}
          />
        </Container>
        <LearningEventDiscussion parent_content_type={this.parent_content_type} parent_id={this.parent_id} />
      </div>
    );
  }
}

const mapStateToProps = store => {
  return {
    learningEvent: store.learningEvent.learningEvent,
    learningEvents: store.learningEvent.learningEvents
  };
};

export default withRouter(connect(mapStateToProps)(LearningEvent));
