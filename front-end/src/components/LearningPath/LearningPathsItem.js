import React, { Component } from "react";
import { Card, Image } from "semantic-ui-react";
import { withRouter } from "react-router-dom";
import axios from "axios";
import { connect } from "react-redux";
import LearningPathProgress from "./LearningPathProgress";

export class LearningPathsItem extends Component {
  state = {
    topicsList: [],
  }

  componentDidMount() {
    const id = this.props.id;

    this.getTopicsList(id);
  };

  completedMLEs = () => {
    let completed = 0;

    if(typeof this.props.course_progress == "undefined") {
      return completed;
    } else {
      if (this.props.course_progress.error) {
        return completed;
      } else {
        completed = this.props.course_progress.requirement_completed_count;

        return completed;
      }
    }
  };

  learningPathProgress = () => {
    const isUserLoggedIn = this.props.isUserLoggedIn;

    if(isUserLoggedIn) {
      const completed = this.completedMLEs();
      const total = this.totalMicroLearningEvents();

      return (
        <Card.Content>
          <LearningPathProgress complete={completed} total={total}/>
        </Card.Content>
      );
    };
  };

  getTopicsList = (id) => {
    const baseUrl = process.env.REACT_APP_SERVICE_HOST;

    axios.get(baseUrl + `/learning_objectives/`, {params: {course_id: id}})
      .then(res => {
        const topicsList = res.data
        this.setState({ topicsList })
      });
  };

  totalMicroLearningEvents = () => {
    const reducer = (totalList, number) => totalList + number;
    const topicsList = this.state.topicsList;

    if(topicsList.length > 0) {
      const total = topicsList.map(topic => topic.items_count).reduce(reducer);

      return total;
    } else {
      return 0
    }
  };

  render() {
    const learningPathDescription = "Maybe it means something more - something we can't yet understand."
    const learningPathImage = `/Image_Placeholder.png`;

    return (
      <Card className="learning-path-card" href={"/learning_paths/" + this.props.id}>
        <Image
          src={learningPathImage}
          alt="Journey Image Placeholder"
        />
        <Card.Content>
          <Card.Header className="learning-path-item-header">{this.props.name}</Card.Header>
          <Card.Meta>{this.props.course_code}</Card.Meta>
          <Card.Description>{learningPathDescription}</Card.Description>
        </Card.Content>
        {this.learningPathProgress()}
      </Card>
    );
  };
};

const mapStateToProps = store => {
  return {
    isUserLoggedIn: store.login.isUserLoggedIn,
  };
};

export default withRouter(connect(mapStateToProps)(LearningPathsItem));
