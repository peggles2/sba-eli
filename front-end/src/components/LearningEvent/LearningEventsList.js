import React, { Component } from "react";
import { List } from "semantic-ui-react";
import { connect } from "react-redux";
import LearningEventsItem from "./LearningEventsItem";
import { getLearningEvents } from "../../actions/learningEventActions";

export class LearningEventsList extends Component {
  componentDidMount() {
    this.eventsList();
  }

  eventsList() {
    this.props.dispatch(getLearningEvents(this.props.course_id, this.props.module_id));
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
    return <List>{this.renderEventsList(this.props.learningEvents)}</List>;
  }
}

const mapStateToProps = store => {
  return {
    learningEvents: store.learningEvent.learningEvents
  };
};

export default connect(mapStateToProps)(LearningEventsList)