import React, { Component } from "react";
import { Icon, Button } from "semantic-ui-react";

export default class LearningEventFooter extends Component {
  render() {

    return (
        <div className="page-navigation-buttons" >
            <Button icon labelPosition='left'>
              <Icon name='left arrow' />
              Previous
            </Button>
            <Button icon labelPosition='right' primary>
              Next
              <Icon name='right arrow' />
            </Button>
        </div>
    );
  }
}
