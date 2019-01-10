import React, { Component } from 'react'
import { Card, Image } from "semantic-ui-react";
import LearningPathProgress from "./LearningPathProgress";
import { withRouter } from 'react-router-dom';
import { connect } from "react-redux";

export class LearningPathsItem extends Component {

  learningPathProgress = (total) => {
    if(this.props.isUserLoggedIn) {
      const complete = 0;

      return (
        <Card.Content>
          <LearningPathProgress complete={complete} total={total}/>
        </Card.Content>
      );
    }
  };

  render() {
    const total = 5;
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
  return { isUserLoggedIn: store.login.isUserLoggedIn }
}

export default withRouter(connect(mapStateToProps)(LearningPathsItem));
