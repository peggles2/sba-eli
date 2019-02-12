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
  getLearningEventsIfNeeded,
  getFirstLearningEvent
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
    const { isUserLoggedIn, match } = this.props;
    const { isUserLoggedIn: prevIsUserLoggedIn, match: prevMatch } = prevProps;

    if (match !== prevMatch || isUserLoggedIn !== prevIsUserLoggedIn) {
      this.setLearningEvent();
    }
  }

  setLearningEvent() {
    const {
      id: course_id,
      topicId: module_id,
      eventId: event_id
    } = this.props.match.params;

    if (event_id === eventProps.first) {
      this.props.dispatch(getFirstLearningEvent(course_id, module_id));
    } else {
      this.props.dispatch(getLearningEventsIfNeeded(course_id, module_id));
      this.props.dispatch(getLearningEvent(course_id, module_id, event_id));
    }
  }

  render() {
    const { learningEvent, topicTitle } = this.props;

    const { id: course_id, topicId: module_id } = this.props.match.params;
    const learningEvents = this.props.learningEventsCollection[course_id]
      ? this.props.learningEventsCollection[course_id][module_id]
      : [];

    return (
      <div>
        <Container className="learning-event-container">
          <MetaTags
            metaTitle={learningEvent.title}
            metaDescription={learningEvent.description}
            canonicalUrl=""
          />
          <LearningEventHeader event={learningEvent} topicTitle={topicTitle} />
          <LearningEventManager
            event={learningEvent}
            courseId={this.props.match.params.id}
          />
          <Divider />
          <LearningEventFooter
            courseId={course_id}
            module={learningEvents}
            event={learningEvent}
          />
        </Container>
        <LearningEventDiscussion />
      </div>
    );
  }
}

const eventProps = {
  first: "first"
};

const mapStateToProps = store => {
  return {
    learningEvent: store.learningEvent.learningEvent,
    learningEventsCollection: store.learningEvent.learningEventsCollection,
    isUserLoggedIn: store.login.isUserLoggedIn
  };
};

export default withRouter(connect(mapStateToProps)(LearningEvent));
