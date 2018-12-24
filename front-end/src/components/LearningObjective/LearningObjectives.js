import React, { Component } from "react";
import LearningObjectivesList from "./LearningObjectivesList";

export default class LearningObjectives extends Component {
  render() {
    return (
      <div>
        <LearningObjectivesList course_id={this.props.match.params.course_id} />
      </div>
    );
  }
}
