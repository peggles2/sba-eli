import React, { Component } from "react";
import { Breadcrumb } from "semantic-ui-react";
import { withRouter } from 'react-router-dom';
import { connect } from "react-redux";

export class LearningPathBreadcrumb extends Component {
  render() {
    return (
      <Breadcrumb>
        <Breadcrumb.Section onClick={() => this.props.history.push('/')}>Home</Breadcrumb.Section>
        <Breadcrumb.Divider icon="triangle right" />
        <Breadcrumb.Section onClick={() => this.props.history.push('/learning_paths/' + this.props.id)}>
          {this.props.pathName}
        </Breadcrumb.Section>
      </Breadcrumb>
    );
  }
}

export default connect((store) => {
  return {}
})(withRouter(LearningPathBreadcrumb));
