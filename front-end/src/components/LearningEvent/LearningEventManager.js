import React, { Component } from "react";
import LearningEventInfoCard from "./LearningEventInfoCard";
import LearningEventPage from "./LearningEventPage";

export default class LearningEventManager extends Component {
  renderEventContentByType() {
    const event = this.props.event;

    if (event.type === "Page") {
      return <LearningEventPage event={event} />;
    } else {
      return <LearningEventInfoCard event={event} />;
    }
  }
  render() {
    return this.renderEventContentByType();
  }
}
