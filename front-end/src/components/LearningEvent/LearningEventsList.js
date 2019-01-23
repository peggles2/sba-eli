import React, { Component } from "react";
import { List } from "semantic-ui-react";
import { connect } from "react-redux";
import LearningEventsItem from "./LearningEventsItem";
import { getLearningEventsIfNeeded } from "../../actions/learningEventActions";

export class LearningEventsList extends Component {
  componentDidMount() {
    this.eventsList();
  }

  eventsList() {
    this.props.dispatch(
      getLearningEventsIfNeeded(this.props.course_id, this.props.module_id)
    );
  }

  renderEventsList(events = []) {
    if (events.length) {
      return events.map(event => {
        return <LearningEventsItem key={event.id} item={event} />;
      });
    }
    return <li>No data</li>;
  }

  render() {
    const { module_id, course_id } = this.props;
    const learningEvents = this.props.learningEventsCollection[course_id]
      ? this.props.learningEventsCollection[course_id][module_id]
      : [];
    return <List>{this.renderEventsList(learningEvents)}</List>;
  }
}

const mapStateToProps = store => {
  return {
    learningEventsCollection: store.learningEvent.learningEventsCollection
  };
};

export default connect(mapStateToProps)(LearningEventsList);
