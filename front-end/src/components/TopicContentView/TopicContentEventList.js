import React, { Component } from "react";
import { Item } from "semantic-ui-react";
import axios from "axios";
import { Link } from "react-router-dom";

export default class TopicContentEventList extends Component {
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

  renderEventList(eventList) {
    const { course_id, module_id } = this.props;
    const url = `/learning_paths/${course_id}/learning_objectives/${module_id}/learning_events/`;
    if (eventList.length) {
      return eventList.map(event => {
        return (
          <Item>
            <Item.Image size="tiny" src="https://via.placeholder.com/50" />

            <Item.Content>
              <Item.Header>
                <Link to={url + event.id}>{event.title}</Link>
              </Item.Header>
              <Item.Meta>Event Type</Item.Meta>
            </Item.Content>
          </Item>
        );
      });
    } else {
      return <div />;
    }
  }

  render() {
    return (
      <Item.Group>{this.renderEventList(this.state.eventsList)}</Item.Group>
    );
  }
}
