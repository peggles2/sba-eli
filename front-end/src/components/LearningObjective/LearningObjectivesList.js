import React, { Component } from "react";
import { List } from "semantic-ui-react";
import { connect } from "react-redux";

import LearningObjectivesItem from "./LearningObjectivesItem";
import { getLearningObjectivesForAdmin } from '../../actions/learningObjectiveActions';

export class LearningObjectivesList extends Component {
  constructor(props) {
    super(props);

    this.state = {
      objectivesList: []
    };
  }

  componentDidMount() {
    this.objectivesList();
  }

  objectivesList() {
    this.props.dispatch(getLearningObjectivesForAdmin(this.props.course_id));
  }

  renderObjectivesList(objectives = []) {
    if (objectives.length) {
      return objectives.map(objective => {
        return <LearningObjectivesItem key={objective.id} course_id={this.props.course_id} item={objective} />;
      });
    }
    return <List.Item>No data</List.Item>;
  }

  render() {
    return <List>{this.renderObjectivesList(this.props.learningObjectives)}</List>;
  }
}

const mapStateToProps = store => {
  return {
    learningObjectives: store.learningObjective.learningObjectives
  };
};

export default connect(mapStateToProps)(LearningObjectivesList);