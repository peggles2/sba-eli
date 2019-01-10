import React, { Component } from 'react'
import { Card, Image } from "semantic-ui-react";
import LearningPathProgress from "./LearningPathProgress";

class LearningPathsItem extends Component {
  state = { isLoggedIn: true }

  learningPathProgress = () => {
    if(this.state.isLoggedIn) {
      return (
        <Card.Content>
          <LearningPathProgress complete={4} total={5}/>
        </Card.Content>
      );
    }
  };

  render() {
    const complete = 3;
    const total = 5;
    const learningPathDescription = "Maybe it means something more - something we can't yet understand."

    return(
      <Card>
        <Image
          src={`/Image_Placeholder.png`}
          alt="learning path image placeholder"
        />
        <Card.Content>
          <Card.Header aria-label={`Link to Learning Path ` + this.props.name}><a href={`/learning_paths/${this.props.id}`}>{this.props.name}</a></Card.Header>
          <Card.Meta>{this.props.course_code}</Card.Meta>
          <Card.Description>{learningPathDescription}</Card.Description>
        </Card.Content>
        {this.learningPathProgress()}
      </Card>
    )
  }
};

export default LearningPathsItem;
