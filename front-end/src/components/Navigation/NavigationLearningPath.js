import React, { Component } from "react";
import { Link } from "react-router-dom";
import { Dropdown, Header } from "semantic-ui-react";
import NavigationLearningObjective from "./NavigationLearningObjective";
import axios from "axios";

export default class NavigationLearningPath extends Component {
  constructor(props) {
    super(props);

    this.state = {
      learningPaths: []
    };
  };

  handleItemClick = (e, {name}) => this.setState({
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

  render() {
    const {activeItem} = this.state
    
    return this.state.learningPaths.map(lp => (
      <Dropdown.Item key={lp.id} style={{width: '300px'}}>
        <Dropdown pointing='left' fluid text={lp.name}>
          <Dropdown.Menu style={{width: '450px' }}>
            <Header as='h1'><Link to={`/learning_paths/${lp.id}`} onClick={this.handleItemClick}>{lp.name}</Link></Header>
            <NavigationLearningObjective learningPathId={lp.id} />
          </Dropdown.Menu>
        </Dropdown>
      </Dropdown.Item>
    ));
  }
}
