import React, { Component } from "react";
import { Breadcrumb } from "semantic-ui-react";

export default class LearningPathBreadCrumb extends Component {
  render() {
    const { id } = this.props;
    return (
      <Breadcrumb>
        <Breadcrumb.Section href="/">Home</Breadcrumb.Section>
        <Breadcrumb.Divider icon="right angle" />
        <Breadcrumb.Section href={`/learning_paths/${id}`}>
          {this.props.pathName}
        </Breadcrumb.Section>
      </Breadcrumb>
    );
  }
}
