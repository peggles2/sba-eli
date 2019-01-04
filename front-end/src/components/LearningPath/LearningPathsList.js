import React from 'react';
import axios from 'axios';
import { Card } from 'semantic-ui-react';
import { connect } from "react-redux";
import LearningPathsItem from './LearningPathsItem';

import { getLearningPaths } from '../../actions/learningPathActions';

export class LearningPathsList extends React.Component {
  componentDidMount() {
    this.props.dispatch(getLearningPaths());
  }

  render() {
    let result = <h3>There are no learning paths available to view at this time</h3>
    if (this.props.learningPaths.length > 0) {
      result = this.props.learningPaths.map(c => <LearningPathsItem key={c.id}
                                                                    id={c.id} 
                                                                    name={c.name} 
                                                                    course_code={c.course_code} />
        )
      }

    return(
      <div>
        <Card.Group itemsPerRow={3}>
          {result}
        </Card.Group>
      </div>
    )
  }
}

export default connect((store) => {
  return {
    learningPaths: store.learningPath.learningPaths
  }
})(LearningPathsList);
