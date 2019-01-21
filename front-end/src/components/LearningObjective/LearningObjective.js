import React, { Component } from "react";
import { connect } from "react-redux";
import { Header } from "semantic-ui-react";
import LearningEventsList from "../LearningEvent/LearningEventsList";
import MetaTags from '../SEO/MetaTags'
import { getLearningObjective } from '../../actions/learningObjectiveActions';

export class LearningObjective extends Component {
  componentDidMount() {
    this.setLearningObjective();
  }

  setLearningObjective() {
    this.props.dispatch(getLearningObjective(this.props.match.params.id, this.props.match.params.course_id));
  }

  render() {
    const learningObjective = this.props.learningObjective || {};
    return (
      <div>
        <MetaTags metaTitle={learningObjective.name}
                  metaDescription={learningObjective.description}
                  canonicalUrl={`https://sba.gov/learning_paths/${this.props.match.params.course_id}/learning_objectives/${this.props.match.params.id}`}/>
        <Header as="h1">{learningObjective.name}</Header>
        <Header as="h4">Micro Learning Events:</Header>
        <LearningEventsList
          course_id={this.props.match.params.id}
          module_id={this.props.match.params.course_id}
        />
      </div>
    );
  }
}

const mapStateToProps = store => {
  return {
    learningObjective: store.learningObjective.learningObjective
  };
};

export default connect(mapStateToProps)(LearningObjective);
