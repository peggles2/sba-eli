import React, { Component } from "react";
import axios from "axios";
import { List } from "semantic-ui-react";
import LearningEventsItem from "./LearningEventsItem";

export default class LearningEventsList extends Component {
  constructor(props) {
    super(props);

    this.state = {
      eventsList: []
    };
  }

  componentDidMount() {
    this.eventsList();
  }

  eventsList() {
    const url = process.env.REACT_APP_SERVICE_HOST + `/learning_events/`;

    const eventParams = {
      course_id: this.props.course_id,
      module_id: this.props.module_id
    };

    axios
      .get(url, { params: eventParams })
      .then(res => {
        const eventsList = res.data;
        this.setState({ eventsList });
      })
      .catch(error => {
        console.log(error);
      });
  }

  renderEventsList(events = []) {
    if (events.length) {
      return events.map(event => {
        return <LearningEventsItem key={event.id} item={event} />;
      });
    }
    return <li>No data</li>;
  }

  render() {
    return <List>{this.renderEventsList(this.state.eventsList)}</List>;
  }
}
