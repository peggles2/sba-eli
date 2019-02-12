import React, { Component } from "react";
import { Link } from "react-router-dom";
import { Divider, List } from "semantic-ui-react";
import { connect } from "react-redux";
import "./Navbar.scss";

import { getObjectivesForAdminIfNeeded } from "../../actions/learningObjectiveActions";

export class NavigationLearningObjective extends Component {
  componentDidMount() {
    this.fetchData();
  }

  fetchData() {
    this.props.dispatch(
      getObjectivesForAdminIfNeeded(this.props.learningPathId)
    );
  }

  topicNumber() {
    const objectives = this.getObjectivesFromCollection();
    const topicNumber = objectives.length;

    if (topicNumber === 1) {
      return topicNumber + " Topic";
    } else {
      return topicNumber + " Topics";
    }
  }

  elide(text) {
    return text.length < 60 ? text : text.substr(0, 60) + "...";
  }

  getFirstEventPath(pathId, objectiveId) {
    return (
      `/learning_paths/${pathId}` +
      `/learning_objectives/${objectiveId}` +
      "/learning_events/first"
    );
  }

  getObjectivesFromCollection() {
    const { adminObjectivesCollection, learningPathId: pathId } = this.props;
    return adminObjectivesCollection[pathId] || [];
  }

  render() {
    const { learningPathId: pathId } = this.props;
    const objectives = this.getObjectivesFromCollection();
    const topics = objectives.map((lo, index) => {
      return (
        <List.Item
          className="navbar-topic-item"
          key={"learning_objective_" + index}
        >
          <Link
            className="navbar-topic-item-link"
            to={this.getFirstEventPath(pathId, lo.id)}
          >
            {this.elide(lo.name)}
          </Link>
        </List.Item>
      );
    });

    return (
      <div className="topic-summary">
        <em>{this.topicNumber()}, 1 hour 24 minutes</em>
        <br />
        <p className="path-description">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eu
          viverra dolor. In pharetra non nunc vitae cursus. Donec fermentum
          vestibulum orci ut aliquam. Phasellus eu arcu scelerisque, pretium
          massa eget, semper justo.
        </p>
        <Divider />
        {topics}
      </div>
    );
  }
}

const mapStateToProps = store => {
  return {
    adminObjectivesCollection: store.learningObjective.adminObjectivesCollection
  };
};

export default connect(mapStateToProps)(NavigationLearningObjective);
