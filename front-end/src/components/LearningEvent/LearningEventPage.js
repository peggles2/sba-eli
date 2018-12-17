import React, { Component } from "react";
import { Container } from "semantic-ui-react";

export default class LearningEventPage extends Component {
  render() {
    const __html = this.props.event.eventContent.body;

    return (
        <div
          dangerouslySetInnerHTML={{
            __html: __html
          }}
        />
    );
  }
}
