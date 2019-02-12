import React, { Component } from "react";
import { List } from "semantic-ui-react";
import { connect } from "react-redux";

import LearningObjectivesItem from "./LearningObjectivesItem";
import { getObjectivesForAdminIfNeeded } from "../../actions/learningObjectiveActions";

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
    this.props.dispatch(getObjectivesForAdminIfNeeded(this.props.course_id));
  }

  renderObjectivesList(objectives = []) {
    if (objectives.length) {
      return objectives.map(objective => {
        return (
          <LearningObjectivesItem
            key={objective.id}
            course_id={this.props.course_id}
            item={objective}
          />
        );
      });
    }
    return <List.Item>No data</List.Item>;
  }

  render() {
    const { adminObjectivesCollection, course_id } = this.props;
    return (
      <List>
        {this.renderObjectivesList(adminObjectivesCollection[course_id])}
      </List>
    );
  }
}

const mapStateToProps = store => {
  return {
    adminObjectivesCollection: store.learningObjective.adminObjectivesCollection
  };
};

export default connect(mapStateToProps)(LearningObjectivesList);
