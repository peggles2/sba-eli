import React, { Component } from "react";
import { Item, Icon } from "semantic-ui-react";
import { Link } from "react-router-dom";
import { connect } from "react-redux";
import { getLearningEvents } from "../../actions/learningEventActions";

export class TopicEventList extends Component {
  componentDidMount() {
    this.eventsList();
  }

  eventsList() {
    this.props.dispatch(getLearningEvents(this.props.course_id, this.props.module_id));
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
        {this.renderEventsList(this.props.learningEvents)}
      </Item.Group>
    );
  }
}

const mapStateToProps = store => {
  return {
    learningEvents: store.learningEvent.learningEvents
  };
};

export default connect(mapStateToProps)(TopicEventList)
