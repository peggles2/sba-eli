import React, { Component } from "react";
import LearningEventInfoCard from "./LearningEventInfoCard";
import LearningEventPage from "./LearningEventPage";
import LearningEventVideo from "./LearningEventVideo";

export default class LearningEventManager extends Component {
  eventFileManager(event) {
    const fileType = event.eventContent.mime_class;

    switch (fileType) {
      case 'video':
        return <LearningEventVideo event={event} />;
      default:
        return this.infoCard(event)
    }
  }

  eventURLManager(event) {
    return this.infoCard(event);
  }

  infoCard(event) {
    return <LearningEventInfoCard event={event} />;
  }

  renderEventContentByType() {
    const event = this.props.event;

    switch(event.type) {
      case 'Page':
        return <LearningEventPage event={event} />;
      case 'File':
        return this.eventFileManager(event);
      case 'ExternalUrl':
        return this.eventURLManager(event);
      default:
        return this.infoCard(event);
    }
  }

  render() {
    return this.renderEventContentByType();
  }
}
