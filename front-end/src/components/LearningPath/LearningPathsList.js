import React, {Component} from "react";
import { Card } from "semantic-ui-react";
import { connect } from "react-redux";
import LearningPathsItem from "./LearningPathsItem";
import './LearningPathsList.scss';

import { getLearningPaths, getLearningPathsProgress } from "../../actions/learningPathActions";

export class LearningPathsList extends Component {
  componentDidMount() {
    this.props.getLearningPaths();
    this.props.getLearningPathsProgress();
  };

  componentDidUpdate(prevProps) {
    const prev = prevProps.isUserLoggedIn;
    const next = this.props.isUserLoggedIn;

    if(prev !== next) {
      this.props.getLearningPaths();
      this.props.getLearningPathsProgress();
    };
  };

  learningPaths = () => {
    const result = this.props.learningPaths.map(c => <LearningPathsItem key={c.id}
                                                                        id={c.id}
                                                                        name={c.name}
                                                                        course_code={c.course_code}
                                                                        custom_data={c.custom_data} />
    )

    return result;
  };

  learningPathsProgress = () => {
    const result = this.props.learningPathsProgress
                    .map(c => <LearningPathsItem key={c.id}
                                                 id={c.id}
                                                 name={c.name}
                                                 course_code={c.course_code}
                                                 course_progress={c.course_progress} />
              )
    return result;
  };

  render() {
    const isUserLoggedIn = this.props.isUserLoggedIn;

    let result = <h3>There are no learning paths available to view at this time</h3>

    if (isUserLoggedIn) {
      if (this.props.learningPathsProgress.length > 0) {
        result = this.learningPathsProgress();
      } else {
        result = this.learningPaths();
      };
    } else {
      if (this.props.learningPaths.length > 0) {
        result = this.learningPaths();
      };
    };

    return <Card.Group id="learningPathCards">{result}</Card.Group>;
  }
}

const mapStateToProps = store => {
  return {
    isUserLoggedIn: store.login.isUserLoggedIn,
    learningPaths: store.learningPath.learningPaths,
    learningPathsProgress: store.learningPath.learningPathsProgress,
  };
};

const mapDispatchToProps = dispatch => {
  return {
    getLearningPaths: () => { dispatch(getLearningPaths()) },
    getLearningPathsProgress: () => { dispatch(getLearningPathsProgress()) },
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(LearningPathsList)
