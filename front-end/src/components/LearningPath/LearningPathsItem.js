import React, { Component } from 'react'
import { Card, Image } from "semantic-ui-react";
import LearningPathProgress from "./LearningPathProgress";
import axios from "axios";
import { withRouter } from 'react-router-dom';
import { connect } from "react-redux";

import { getLearningEvents } from "../../actions/learningEventActions";

export class LearningPathsItem extends Component {
  state = { topicsList: [] }

  componentDidMount() {
    this.getTopicsList();
  }

  learningPathProgress = (total) => {
    // const isUserLoggedIn = this.props.isUserLoggedIn
    const isUserLoggedIn = true;
    if(isUserLoggedIn) {
      const complete = 0;

      return (
        <Card.Content>
          <LearningPathProgress complete={complete} total={total}/>
        </Card.Content>
      );
    }
  };

  getTopicsList = () => {
    const baseUrl = process.env.REACT_APP_SERVICE_HOST;

    axios.get(baseUrl + `/learning_objectives/`, {params: {course_id: this.props.id}})
      .then(res => {
        const topicsList = res.data
        this.setState({ topicsList })
      })
  }

  totalMicroLearningEvents = () => {
    const reducer = (totalList, number) => totalList + number;
    const topicsList = this.state.topicsList;

    if(topicsList.length > 0) {
      const total = topicsList.map(topic => topic.items_count).reduce(reducer);

      return total;
    } else {
      return 0
    }
  }

  render() {
    const total = this.totalMicroLearningEvents();
    const learningPathDescription = "Maybe it means something more - something we can't yet understand."

    return(
      <Card>
        <Image
          src={`/Image_Placeholder.png`}
          alt="learning path image placeholder"
        />
        <Card.Content>
          <Card.Header aria-label={`Link to Learning Path ` + this.props.name}>
            <a href="#" onClick={() => { this.props.history.push('/learning_paths/' + this.props.id)}}>{this.props.name}</a>
          </Card.Header>
          <Card.Meta>{this.props.course_code}</Card.Meta>
          <Card.Description>{learningPathDescription}</Card.Description>
        </Card.Content>
        {this.learningPathProgress(total)}
      </Card>
    )
  }
};

const mapStateToProps = (store) => {
  return {
    isUserLoggedIn: store.login.isUserLoggedIn,
  }
}

export default withRouter(connect(mapStateToProps)(LearningPathsItem));
