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
    const objectives = this.state.learningObjectives || [];
    const topicNumber = objectives.length;

    if (topicNumber === 1) {
      return topicNumber + " Topic";
    } else {
      return topicNumber + " Topics";
    }
  }

  render() {
    const learningObjectivePath = `/learning_paths/${this.props.learningPathId}/learning_objectives/`
    const objectives = this.state.learningObjectives || [];
    const topics = objectives.map((lo, index) => (
      <List.Item key={'learning_objective_' + index}><Link to={learningObjectivePath + lo.id} onClick={this.handleItemClick}>{lo.name}</Link></List.Item>
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
