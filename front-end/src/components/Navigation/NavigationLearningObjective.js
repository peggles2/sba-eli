import React, { Component } from "react";
import { Link } from 'react-router-dom';
import { Divider, List } from "semantic-ui-react";
import { connect } from "react-redux";

import { getLearningObjectives } from '../../actions/learningObjectiveActions';

export class NavigationLearningObjective extends Component {
  componentDidMount() {
    this.fetchData();
  }

  fetchData() {
    this.props.dispatch(getLearningObjectives(this.props.learningPathId));
  }

  topicNumber() {
    const objectives = this.props.learningObjectives || [];
    const topicNumber = objectives.length;

    if (topicNumber === 1) {
      return topicNumber + " Topic";
    } else {
      return topicNumber + " Topics";
    }
  }

  elide(text) {
    return text.length < 60 ? text : text.substr(0, 60) + '...';
  };

  render() {
    const learningObjectivePath = `/learning_paths/${this.props.learningPathId}/learning_objectives/`
    const objectives = this.props.learningObjectives || [];
    const topics = objectives.map((lo, index) => (
      <List.Item key={'learning_objective_' + index}><Link to={learningObjectivePath + lo.id}>{this.elide(lo.name)}</Link></List.Item>
    ));

    return (
      <div className='topic-summary'>
        <em>{this.topicNumber()}, 1 hour 24 minutes</em><br/>
        <p className='path-description'>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eu viverra dolor. In pharetra non nunc vitae cursus. Donec fermentum vestibulum orci ut aliquam. Phasellus eu arcu scelerisque, pretium massa eget, semper justo.</p>
        <Divider />
        { topics }
      </div>
    )
  }
}

const mapStateToProps = store => {
  return {
    learningObjectives: store.learningObjective.learningObjectives
  };
};

export default connect(mapStateToProps)(NavigationLearningObjective);
