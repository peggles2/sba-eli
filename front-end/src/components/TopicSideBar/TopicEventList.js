import React, { Component } from "react";
import { Item, Icon } from "semantic-ui-react";
import { Link } from "react-router-dom";
import { connect } from "react-redux";
import { getLearningEventsIfNeeded } from "../../actions/learningEventActions";

export class TopicEventList extends Component {
  componentDidMount() {
    this.eventsList();
  }

  eventsList() {
    this.props.dispatch(
      getLearningEventsIfNeeded(this.props.course_id, this.props.module_id)
    );
  }

  getIcon(eventType){
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
          <Item key={"eventListItem" + index} className={itemClassName} href={url + event.id}>
            <Item.Header>
              <Icon
                className={"event-list-item-icon"}
                name={completed}
                size="big"
              />
              {event.title}
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
    const { module_id, course_id } = this.props;
    const learningEvents = this.props.learningEventsCollection[course_id]
      ? this.props.learningEventsCollection[course_id][module_id]
      : [];

    return (
      <Item.Group divided>{this.renderEventsList(learningEvents)}</Item.Group>
    );
  }
}

const mapStateToProps = store => {
  return {
    learningEventsCollection: store.learningEvent.learningEventsCollection
  };
};

export default connect(mapStateToProps)(TopicEventList);
