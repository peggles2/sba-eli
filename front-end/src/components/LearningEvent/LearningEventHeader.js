import React, { Component } from "react";
import { Header, Divider, Grid } from "semantic-ui-react";
import DownloadButton from "./DownloadButton";
import "./LearningEvent.scss";

class LearningEventHeader extends Component {
  showDownloadButton(event) {
    if (event.type === "File") {
      return <DownloadButton className="share-button" url="" />;
    }
    return null;
  }

  getCustomData(event, field, defaultValue) {
    if (!event || !event.custom_data || !field){
      return defaultValue;
    }
    return event.custom_data[field];
  };

  render() {
    const { event, topicTitle } = this.props;
    return (
      <Grid className="learning-event-header">
        <Grid.Row className="header-row">
          <Grid.Column>
            <div className="topic-title">{topicTitle}</div>
          </Grid.Column>
        </Grid.Row>
        <Grid.Row className="header-row">
          <Grid.Column>
            <Header className="event-title" as="h1">
              {event.title}
            </Header>
          </Grid.Column>
        </Grid.Row>
        <Grid.Row className="header-row">
          <Grid.Column width={12}>
            <div className="event-meta">
              {this.getCustomData(event, 'event_type', 'Article')} ({this.getCustomData(event, 'time', 'unknown')})
            </div>
          </Grid.Column>
          <Grid.Column width={4}>
            {this.showDownloadButton(event)}
          </Grid.Column>
        </Grid.Row>
        <Grid.Row className="header-row">
          <Grid.Column>
            <Divider />
          </Grid.Column>
        </Grid.Row>
      </Grid>
    );
  }
}

export default LearningEventHeader;
