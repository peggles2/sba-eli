import React, { Component } from "react";
import LearningObjectivesList from "./LearningObjectivesList";
import MetaTags from '../SEO/MetaTags'

export default class LearningObjectives extends Component {
  render() {
    return (
      <div>
        <MetaTags metaTitle="SBA Learning Objectives"
                  metaDescription="Description for the Learning Objectives landing page"
                  canonicalUrl={`https://sba.gov/learning_paths/${this.props.match.params.course_id}/learning_objectives`}/>
        <LearningObjectivesList course_id={this.props.match.params.course_id} />
      </div>
    );
  }
}
