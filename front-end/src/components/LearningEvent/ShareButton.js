import React from "react";
import { Button, Icon } from "semantic-ui-react";

const ShareButton = props => {
  return (
    <Button icon aria-label="share" className="header-button">
      <Icon name="share" />
    </Button>
  );
};

export default ShareButton;
