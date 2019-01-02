import React, { Component } from "react";
import mime from "mime-types";
import LearningEventInfoCard from "./LearningEventInfoCard";
import LearningEventPage from "./LearningEventPage";
import LearningEventVideo from "./LearningEventVideo";
import LearningEventPodcast from "./LearningEventPodcast";

export default class LearningEventManager extends Component {
  getMimeType(url) {
    if ( mime.lookup(url) ) {
      return mime.lookup(url).split("/")[0];
    } else {
      return "NONE";
    }
  }

  eventFileManager(event) {
    const fileType = event.eventContent.mime_class;
    const url = event.eventContent.url;

    switch (fileType) {
      case 'video':
        return <LearningEventVideo url={url} event={event} />;
      case 'audio':
        return <LearningEventPodcast url={url} event={event}/>;
      default:
        return this.infoCard(event)
    }
  }

  eventURLManager(event) {
    const url = event.external_url;
    const mimeType = this.getMimeType(url);

    switch(mimeType) {
      case 'video':
        return <LearningEventVideo url={url} event={event}/>;
      case 'audio':
        return <LearningEventPodcast url={url} event={event}/>;
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
