import React, { Component } from 'react'
import { Card, Image } from 'semantic-ui-react';
import { withRouter } from 'react-router-dom';
import { connect } from "react-redux";

export class LearningPathsItem extends Component {
  render() {
    return (
      <Card>
        <Image 
          src={`/Image_Placeholder.png`} 
          alt="learning path image placeholder"
        />
        <Card.Content>
          <Card.Header><a href={'/learning_paths/' + this.props.id}>{this.props.name}</a></Card.Header>
          <Card.Meta>{this.props.course_code}</Card.Meta>
          <Card.Description>Maybe it means something more - something we can't yet understand.</Card.Description>
        </Card.Content>
      </Card>
    )
  }
}

export default connect((store) => {
  return {}
})(withRouter(LearningPathsItem));