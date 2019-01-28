import React, { Component } from 'react'
import { Card, Image } from "semantic-ui-react";
import LearningPathProgress from "./LearningPathProgress";
import axios from "axios";
import { withRouter } from 'react-router-dom';
import { connect } from "react-redux";

import { getLearningPathProgress } from "../../actions/learningPathActions";

export class LearningPathsItem extends Component {
  state = {
    topicsList: [],
    completedMLE: 0,
  }

  componentDidMount() {
    const isUserLoggedIn = this.props.isUserLoggedIn;
    const id = this.props.id

    this.getTopicsList();
    this.props.getCompletedMLE(id);
  }


  learningPathProgress = (total) => {
    const isUserLoggedIn = this.props.isUserLoggedIn;

    if(isUserLoggedIn) {
      const { completedMLE, completedMLEError } = this.props
      let completed = 0;

      if(completedMLEError) {
        completed = 0;
      } else {
        completed = completedMLE.requirement_completed_count;
      }

      console.log("COMPLETED: ", completed)

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
          <Card.Header><a href={'/learning_paths/' + this.props.id}>{this.props.name}</a></Card.Header>
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
    learningPathProgress: store.learningPath.learningPathProgress,
    completedMLE: store.learningPath.completedMLE,
    completedMLEError: store.learningPath.completedMLEError,
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    getCompletedMLE: (id) => {
      dispatch(getLearningPathProgress(id));
    }
  }
}

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(LearningPathsItem));
