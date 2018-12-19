import React, { Component } from "react";
import axios from "axios";
import { Dropdown } from "semantic-ui-react";
import NavigationLearningEventItem from "./NavigationLearningEventItem";

export default class NavigationLearningEvent extends Component {
  constructor(props) {
    super(props);

    this.state = {
      learningEvents: []
    };
  }

  static getEventPath(course_id, module_id, event_id){
      return (
          `/learning_paths/${course_id}` +
          `/learning_objectives/${module_id}` +
          `/learning_events/${event_id}`)
  }

  componentDidMount() {
    this.fetchData();
  }

  fetchData() {
    const url = process.env.REACT_APP_SERVICE_HOST + `/learning_events/`;

    const eventParams = {
      course_id: this.props.learningPathId,
      module_id: this.props.learningObjectiveId
    };

    axios
      .get(url, { params: eventParams })
      .then(res => {
        const learningEvents = res.data;
        this.setState({ learningEvents });
      })
      .catch(error => {
        console.log(error);
      });
  }

  renderLearningEvents(learningEvents = []) {
    if (learningEvents.length) {
      const course_id = this.props.learningPathId;
      const module_id = this.props.learningObjectiveId;
      return learningEvents.map(event => {
        const path = NavigationLearningEvent.getEventPath(course_id, module_id, event.id)
        return (
          <NavigationLearningEventItem
            key={event.id + course_id + module_id}
            path={path}
            name={event.title}
          />
        );
      });
    }

    return <NavigationLearningEventItem path="/" name="No data" />;
  }

  render() {
    return (
      <Dropdown item text={this.props.name}>
        <Dropdown.Menu>
          {this.renderLearningEvents(this.state.learningEvents)}
        </Dropdown.Menu>
      </Dropdown>
    );
  }
}
