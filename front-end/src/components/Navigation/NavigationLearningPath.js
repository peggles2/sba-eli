import React, { Component } from "react";
import { Link } from "react-router-dom";
import { Dropdown, Header } from "semantic-ui-react";
import NavigationLearningObjective from "./NavigationLearningObjective";
import { connect } from "react-redux";
import { getLearningPaths } from "../../actions/learningPathActions";

import "./Navbar.scss";

export class NavigationLearningPath extends Component {
  constructor(props) {
    super(props);

    this.state = {
      learningPaths: []
    };
  }

  handleItemClick = (e, { name }) =>
    this.setState({
      activeItem: name
    });

  componentDidMount() {
    this.fetchData();
  }

  componentDidUpdate(prevProps) {
    if (this.props.isUserLoggedIn !== prevProps.isUserLoggedIn) {
      this.fetchData();
    }
  }

  fetchData() {
    this.props.dispatch(getLearningPaths());
  }

  render() {
    const learningPaths = this.props.learningPaths || [];
    return learningPaths.map(lp => (
      <Dropdown.Item key={lp.id} className="learning-path-item">
        <Dropdown
          className="navigation-learning-path"
          pointing="left"
          fluid
          text={lp.name}
        >
          <Dropdown.Menu>
            <Header as="h1">
              <Link
                to={`/learning_paths/${lp.id}`}
                onClick={this.handleItemClick}
              >
                {lp.name}
              </Link>
            </Header>
            <NavigationLearningObjective learningPathId={lp.id} />
          </Dropdown.Menu>
        </Dropdown>
      </Dropdown.Item>
    ));
  }
}

const mapStateToProps = store => {
  return {
    learningPaths: store.learningPath.learningPaths,
    isUserLoggedIn: store.login.isUserLoggedIn
  };
};

export default connect(mapStateToProps)(NavigationLearningPath);
