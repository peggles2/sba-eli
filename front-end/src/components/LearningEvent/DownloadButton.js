import React from "react";
import { Button, Icon } from "semantic-ui-react";

const DownloadButton = (props) => {
  return (
    <Button icon as='a' href={props.url} aria-label="download" download>
      <Icon name='download' size='large'/>
    </Button>
  )
}

export default DownloadButton;
