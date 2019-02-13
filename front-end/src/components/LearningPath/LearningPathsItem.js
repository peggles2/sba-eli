import React, { Component } from "react";
import { Card, Image } from "semantic-ui-react";
import { withRouter } from "react-router-dom";
import { connect } from "react-redux";
import LearningPathProgress from "./LearningPathProgress";

export class LearningPathsItem extends Component {

  completedMicroLearningEvents = () => {
    let completed = 0;

    const courseProgress = this.props.course_progress;

    if(!courseProgress.error && courseProgress.requirement_completed_count) {
      completed = courseProgress.requirement_completed_count;
    } 
    return completed;
  };

  totalMicroLearningEvents = () => {
    let total = 0;

    const courseProgress = this.props.course_progress;

    if(!courseProgress.error && courseProgress.requirement_count) {
      total = courseProgress.requirement_count;
    }
    return total;
  };

  learningPathProgress = () => {
    const { isUserLoggedIn, hasUserStartedJourney } = this.props

    if(isUserLoggedIn && hasUserStartedJourney) {
      const completed = this.completedMicroLearningEvents();
      const total = this.totalMicroLearningEvents();

      return (
        <Card.Content>
          <LearningPathProgress complete={completed} total={total}/>
        </Card.Content>
      );
    };
  };


  getCustomData(customData, field, defaultValue) {
    if (!customData || !field){
      return defaultValue;
    }
    return customData[field];
  };

  render() {
    const defaultDescription = "Maybe it means something more - something we can't yet understand."
    const defaultImage = `/Image_Placeholder.png`;

    return (
      <Card className="learning-path-card" href={"/learning_paths/" + this.props.id}>
        <Image
          src={this.getCustomData(this.props.custom_data, "thumbnail_url", defaultImage)}
          alt="Journey Image Placeholder"
        />
        <Card.Content>
          <Card.Header className="learning-path-item-header">{this.props.name}</Card.Header>
          <Card.Meta>{this.props.course_code}</Card.Meta>
          <Card.Description>{this.getCustomData(this.props.custom_data, "description", defaultDescription)}</Card.Description>
        </Card.Content>
        {this.learningPathProgress()}
      </Card>
    );
  };
};

const mapStateToProps = store => {
  return {
    isUserLoggedIn: store.login.isUserLoggedIn,
    hasUserStartedJourney: store.learningPath.hasUserStartedJourney,
  };
};

export default withRouter(connect(mapStateToProps)(LearningPathsItem));
