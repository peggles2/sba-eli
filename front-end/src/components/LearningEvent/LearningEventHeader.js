import React from "react";
import { Header } from "semantic-ui-react";

const LearningEventHeader = (props) => {
  const event = props.event;

  return(
    <div>
      <Header size='medium'>Avengers</Header>
      <Header size='huge'>{event.title}</Header>
    </div>
  )
}

export default LearningEventHeader;
