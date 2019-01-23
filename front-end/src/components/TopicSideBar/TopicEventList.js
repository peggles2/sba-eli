import React, { Component } from "react";
import axios from "axios";
import { Item, Icon } from "semantic-ui-react";
import { Link } from "react-router-dom";

export default class TopicEventList extends Component {
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

  getIcon(eventType){
    console.log("Event ", eventType)
    switch(eventType){
      case "Quiz":
        return "pencil alternate";
      default:
        return "image";
    }
  }

  renderEventsList(events = []) {
    const { course_id, module_id, event_id } = this.props;
    const url = `/learning_paths/${course_id}/learning_objectives/${module_id}/learning_events/`;

    if (events.length) {
      return events.map((event, index) => {
        const itemClassName =
          event_id && event_id.toString() === event.id.toString()
            ? "event-list-accordion-item active-event"
            : "event-list-accordion-item";

        const completed =
          event.completion_requirement && event.completion_requirement.completed
            ? "check"
            : "image";
        return (
          <Item key={"eventListItem" + index} className={itemClassName}>
            <Item.Header>
              <Icon
                className={"event-list-item-icon"}
                name={completed}
                size="big"
              />
              <Link className={"event-list-item-link"} to={url + event.id}>
                {event.title}
              </Link>
            </Item.Header>
          </Item>
        );
      });
    }
    return (
      //Placeholder for no event, TODO expand on this
      <Item className={"event-list-accordion-item"}>
        <Item.Header>
          <Icon className={"event-list-item-icon"} name="image" size="big" />
          <Link className={"event-list-item-link"} to={"#"}>
            Learning Event
          </Link>
        </Item.Header>
      </Item>
    );
  }

  render() {
    return (
      <Item.Group divided>
        {this.renderEventsList(this.state.eventsList)}
      </Item.Group>
    );
  }
}
