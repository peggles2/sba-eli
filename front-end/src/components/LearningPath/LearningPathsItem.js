import React, { Component } from 'react'
import { Card, Image } from "semantic-ui-react";
import LearningPathProgress from "./LearningPathProgress";
import axios from "axios";
import { withRouter } from 'react-router-dom';
import { connect } from "react-redux";

import { getLearningEvents } from "../../actions/learningEventActions";

export class LearningPathsItem extends Component {
  state = {
    topicsList: [],
    completedMLE: 0,
  }

  componentDidMount() {
    const isUserLoggedIn = this.props.isUserLoggedIn;

    this.getTopicsList();
    this.getCompletedMicroLearningEvents();
  }

  learningPathProgress = (total) => {
    const isUserLoggedIn = this.props.isUserLoggedIn;

    if(isUserLoggedIn) {
      const completed = this.state.completedMLE;

      return (
        <Card.Content>
          <LearningPathProgress complete={completed} total={total}/>
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
      });
  }

  getCompletedMicroLearningEvents = () => {
    const isUserLoggedIn = this.props.isUserLoggedIn;
    const baseUrl = process.env.REACT_APP_SERVICE_HOST;
    const id = this.props.id;
    const url = baseUrl + `/learning_paths/${id}/progress`

    if (isUserLoggedIn) {
      const accessToken = this.props.accessToken;
      console.log("ACCESS TOKEN " + accessToken)
      const auth_header = { headers: { "AUTHORIZATION": accessToken } }

      axios.get(url, auth_header)
        .then(response => {
          const data = response.data
          // const completed = res.data.course_progress.requirement.completed_count;
          // this.setState({completedMLE: completed})
          console.log("DATA: ", data);
        });
    }

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
            <a onClick={() => { this.props.history.push('/learning_paths/' + this.props.id)}}>{this.props.name}</a>
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
  const { login } = store
  return {
    isUserLoggedIn: login.isUserLoggedIn,
    accessToken: login.userData.access_token
  }
}

export default withRouter(connect(mapStateToProps)(LearningPathsItem));
