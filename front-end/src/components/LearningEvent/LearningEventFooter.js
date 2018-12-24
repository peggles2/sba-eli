import React from "react";
import { Button, Icon } from "semantic-ui-react";

const LearningEventFooter = () => {
  return (
    <div className="learning-event-footer">
      <Button.Group floated='right'>
        <Button icon labelPosition="left" aria-label="previous">
          <Icon name='angle left' />
          Previous
        </Button>
        <Button primary icon labelPosition="right" aria-label="next">
          Next
          <Icon name='angle right' />
        </Button>
      </Button.Group>
    </div>
  )
}

export default LearningEventFooter;
