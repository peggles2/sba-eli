import React, { Component } from "react";
import axios from "axios";
import { Header } from "semantic-ui-react";
import LearningEventsList from "../LearningEvent/LearningEventsList";
import MetaTags from '../SEO/MetaTags'

export default class LearningObjective extends Component {
  constructor(props) {
    super(props);

    this.state = {
      learningObjective: {}
    };
  }

  componentDidMount() {
    this.setLearningObjective();
  }

  setLearningObjective() {
    const objective_id = this.props.match.params.id;
    const url =
      process.env.REACT_APP_SERVICE_HOST +
      `/learning_objectives/${objective_id}`;

    const objectiveParams = {
      course_id: this.props.match.params.course_id
    };

    axios
      .get(url, { params: objectiveParams })
      .then(res => {
        const learningObjective = res.data;

        this.setState({ learningObjective });
      })
      .catch(error => {
        console.log(error);
      });
  }

  render() {
    const learningObjective = this.state.learningObjective || {};
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
