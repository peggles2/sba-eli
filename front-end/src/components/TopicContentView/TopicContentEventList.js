import React, { Component } from "react";
import { Icon, Grid } from "semantic-ui-react";
import { Link } from "react-router-dom";
import { connect } from "react-redux";
import { getLearningEvents } from "../../actions/learningEventActions";

export class TopicContentEventList extends Component {
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
    this.props.dispatch(getLearningEvents(this.props.course_id, this.props.module_id));
  }

  renderEventList(eventList) {
    const { course_id, module_id } = this.props;
    const url = `/learning_paths/${course_id}/learning_objectives/${module_id}/learning_events/`;

    if (eventList && eventList.length) {
      return eventList.map(event => {
        return (
          <Grid
            className={"topic-content-event-grid"}
            key={"topicContentItem" + event.id}
          >
            <Grid.Column
              mobile={4}
              tablet={3}
              computer={2}
              largeScreen={1}
              widescreen={1}
            >
              <Icon
                name={"image"}
                className={"topic-content-event-grid-icon"}
              />
            </Grid.Column>
            <Grid.Column
              mobile={12}
              tablet={13}
              computer={14}
              largeScreen={13}
              widescreen={15}
            >
              <Link
                className={"topic-content-event-grid-header"}
                to={url + event.id}
              >
                {event.title}
              </Link>
              <div className={"topic-content-event-grid-meta"}>Event Type</div>
            </Grid.Column>
          </Grid>
        );
      });
    } else {
      return null;
    }
  }

  render() {
    return this.renderEventList(this.props.learningEvents);
  }
}

const mapStateToProps = store => {
  return {
    learningEvents: store.learningEvent.learningEvents
  };
};

export default connect(mapStateToProps)(TopicContentEventList)
