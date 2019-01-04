import React, { Component } from "react";
import "./LearningEventPageContent.scss";

export default class LearningEventPage extends Component {
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
