import React, { Component } from 'react'
import { Card } from 'semantic-ui-react';
import { withRouter } from 'react-router-dom';
import { connect } from "react-redux";

class LearningPathsItem extends Component {
  render() {
    return (
      <Card>
        <Card.Content>
          <Card.Header><a onClick={() => { this.props.history.push('/learning_paths/' + this.props.id)}}>{this.props.name}</a></Card.Header>
          <Card.Meta>{this.props.course_code}</Card.Meta>
        </Card.Content>
      </Card>
    )
  }
}

export default connect((store) => {
  return {}
})(withRouter(LearningPathsItem));