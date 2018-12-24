import React, { Component } from "react";
import LearningEventsList from "./LearningEventsList";

export default class LearningEvents extends Component {
  render() {
    return (
      <div>
        <LearningEventsList
          course_id={this.props.match.params.course_id}
          module_id={this.props.match.params.module_id}
        />
      </div>
    );
  }
}
