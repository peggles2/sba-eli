import React, { Component } from "react";
import mime from "mime-types";
import LearningEventInfoCard from "./LearningEventInfoCard";
import LearningEventPage from "./LearningEventPage";
import LearningEventVideo from "./LearningEventVideo";

export default class LearningEventManager extends Component {
  eventFileManager(event) {
    const fileType = event.eventContent.mime_class;
    const url = event.eventContent.url;

    switch (fileType) {
      case 'video':
        return <LearningEventVideo url={url} event={event} />;
      default:
        return this.infoCard(event)
    }
  }

  eventURLManager(event) {
    const url = event.external_url;
    const mimeType = mime.lookup(url).split("/")[0];

    switch(mimeType) {
      case 'video': 
        return <LearningEventVideo url={url} event={event}/>;
      default:
        return this.infoCard(event);
    }
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
