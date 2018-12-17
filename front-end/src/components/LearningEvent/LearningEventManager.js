import React, { Component } from "react";
import LearningEventInfoCard from "./LearningEventInfoCard";
import LearningEventPage from "./LearningEventPage";
import LearningEventFile from "./LearningEventFile";
import LearningEventVideo from "./LearningEventVideo";

export default class LearningEventManager extends Component {
  eventFileManager(event) {
    const fileType = event.eventContent.mime_class;

    if (fileType === "video") {
      return <LearningEventVideo event={event} />;
    } else {
      return this.infoCard(event); 
    }
  }

  infoCard(event) {
    return <LearningEventInfoCard event={event} />;
  }

  renderEventContentByType() {
    const event = this.props.event;

    if (event.type === "Page") {
      return <LearningEventPage event={event} />;
    } else if (event.type === "File") {
      return this.eventFileManager(event);
    } else {
      return this.infoCard(event); 
    }
  }
  render() {
    return this.renderEventContentByType();
  }
}
