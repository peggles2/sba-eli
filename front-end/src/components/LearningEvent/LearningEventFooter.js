import React from "react";
import { Button, Icon } from "semantic-ui-react";

const LearningEventFooter = () => {
  return (
    <div>
      <Button icon labelPosition="left">
        <Icon name='angle left' />
        Previous 
      </Button>
      <Button primary icon labelPosition="right">
        Next
        <Icon name='angle right' />
      </Button>
    </div>
  )
}

export default LearningEventFooter;
