import React, { Component } from "react";
import { Link } from "react-router-dom";
import { Dropdown, Header, Image } from "semantic-ui-react";
import NavigationLearningObjective from "./NavigationLearningObjective";
import axios from "axios";
import { connect } from "react-redux";

import './Navbar.scss'

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

  fetchData() {
    const url = process.env.REACT_APP_SERVICE_HOST + "/learning_paths";

    axios
      .get(url)
      .then(res => {
        const learningPaths = res.data;
        this.setState({ learningPaths });
      })
      .catch(error => {
        console.error(error);
      });
  }

  renderPathForLoggedIn(lp) {
    const { isUserLoggedIn } = this.props;
    if (isUserLoggedIn) {
      return (
        <Dropdown pointing="left" fluid text={lp.name}>
          <Dropdown.Menu style={{ width: "450px" }}>
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
      );
    } else {
      return (
        <Dropdown.Item>
          <Link to={`/learning_paths/${lp.id}`} onClick={this.handleItemClick}>
            {lp.name}
          </Link>
        </Dropdown.Item>
      );
    }
  }

  render() {
    const learningPaths = this.state.learningPaths || [];
    return learningPaths.map(lp => (
      <Dropdown.Item key={lp.id} className='learning-path-item'>
        {this.renderPathForLoggedIn(lp)}
      </Dropdown.Item>
    ));
  }
}

const mapStateToProps = store => {
  return { isUserLoggedIn: store.login.isUserLoggedIn };
};

export default connect(mapStateToProps)(NavigationLearningPath);
