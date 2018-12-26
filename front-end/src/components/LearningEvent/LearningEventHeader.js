import React from "react";
import { Header, Divider, Button, Icon, Grid } from "semantic-ui-react";

const LearningEventHeader = props => {
  const event = props.event;

  return (
    <Grid className="learning-event-header">
      <Grid.Row>
        <Grid.Column>
          <div className="topic-title">Topic Title</div>
        </Grid.Column>
      </Grid.Row>
      <Grid.Row>
        <Grid.Column>
          <Header className="event-title" as="h1">
            {event.title}
          </Header>
        </Grid.Column>
      </Grid.Row>
      <Grid.Row>
        <Grid.Column width={12}>
          <div className="event-meta">Event Type (Time)</div>
        </Grid.Column>
        <Grid.Column width={4}>
          <Button className="share-button" icon>
            <Icon name="share" />
          </Button>
        </Grid.Column>
      </Grid.Row>
      <Grid.Row>
        <Grid.Column>
          <Divider />
        </Grid.Column>
      </Grid.Row>
    </Grid>
  );
};

export default LearningEventHeader;
