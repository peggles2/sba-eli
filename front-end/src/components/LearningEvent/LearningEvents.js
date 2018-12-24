import React, { Component } from "react";
import LearningEventsList from "./LearningEventsList";
import MetaTags from '../SEO/MetaTags'

export default class LearningEvents extends Component {
  render() {
    return (
      <div>
        <MetaTags metaTitle="Learning Events"
                  metaDescription="Description for the Learning Events landing page"
                  canonicalUrl={`https://sba.gov/learning_paths/${this.props.match.params.course_id}/learning_objectives/${this.props.match.params.module_id}/learning_events`}/>
        <LearningEventsList
          course_id={this.props.match.params.course_id}
          module_id={this.props.match.params.module_id}
        />
      </div>
    );
  }
}
