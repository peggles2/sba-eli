import React, { Component } from "react";
import { Link } from 'react-router-dom';
import { Divider, List } from "semantic-ui-react";
import axios from "axios";

export default class NavigationLearningObjective extends Component {
  constructor(props) {
    super(props);

    this.state = {
      learningObjectives: []
    };
  }

  handleItemClick = (e, {name}) => this.setState({
    activeItem: name
  });

  componentDidMount() {
    this.fetchData();
  }

  fetchData() {
    const url =
      process.env.REACT_APP_SERVICE_HOST +
      "/learning_objectives/" +
      "?course_id=" +
      this.props.learningPathId;

    axios
      .get(url)
      .then(res => {
        const learningObjectives = res.data;
        this.setState({ learningObjectives });
      })
      .catch(error => {
        console.error(error);
      });
  }

  topicNumber() {
    const topicNumber = this.state.learningObjectives.length;

    if (topicNumber === 1) {
      return topicNumber + " Topic";
    } else {
      return topicNumber + " Topics";
    }
  }

  render() {
    const learningObjectivePath = `/learning_paths/${this.props.learningPathId}/learning_objectives/`

    const topics = this.state.learningObjectives.map((lo, index) => (
      <List.Item key={'learning_objective_' + index}><Link to={learningObjectivePath + lo.id} onClick={this.handleItemClick}>{lo.name}</Link></List.Item>
    ));

    return (
      <div>
        <em>{this.topicNumber()}</em>
        <Divider />
        { topics }
      </div>
    )
  }
}
