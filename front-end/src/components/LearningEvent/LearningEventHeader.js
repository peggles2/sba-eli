import React from "react";
import { Header } from "semantic-ui-react";

const LearningEventHeader = (props) => {
  const event = props.event;

  return(
    <div className="learning-event-header">
      <Header as='h1'>{event.title}</Header>
    </div>
  )
}

export default LearningEventHeader;
