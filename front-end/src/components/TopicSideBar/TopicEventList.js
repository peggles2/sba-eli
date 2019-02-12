import React, { Component } from "react";
import { Item, Icon, Image } from "semantic-ui-react";
import { Link, withRouter } from "react-router-dom";
import { connect } from "react-redux";
import { getLearningEventsIfNeeded } from "../../actions/learningEventActions";

export class TopicEventList extends Component {
  constructor(props) {
    super(props);

    this.handleItemClick = this.handleItemClick.bind(this);
  }
  componentDidMount() {
    this.eventsList();
  }

  eventsList() {
    this.props.dispatch(
      getLearningEventsIfNeeded(this.props.course_id, this.props.module_id)
    );
  }

  getCustomData(event, field, defaultValue) {
    if (!event || !event.custom_data || !field){
      return defaultValue;
    }
    return event.custom_data[field];
  };

  handleItemClick(url) {
    this.props.history.push(url);
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

        const eventType = this.getCustomData(event, 'event_type', event.type);
        const imageUrl = "https://s3.amazonaws.com/sba-eli-assets-s3-bucket-dev/Platform+Graphics/Left+Nav+Icons/" + eventType + "-nav.png";
        return (
          <Item
            key={"eventListItem" + index}
            className={itemClassName}
            onClick={() => this.handleItemClick(url + event.id)}
          >
            <Item.Image src={imageUrl} size="tiny"/>
            <Item.Content>
              <Item.Description>{event.title}</Item.Description>
            </Item.Content>
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

export default withRouter(connect(mapStateToProps)(TopicEventList));
