import React from "react";
import { Button, Icon } from "semantic-ui-react";

const DownloadButton = props => {
  return (
    <Button
      icon
      as="a"
      href={props.url}
      aria-label="download"
      download
      className="mobile hidden"
      floated="right"
    >
      <Icon name="download" />
    </Button>
  );
};

export default DownloadButton;
