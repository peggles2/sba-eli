import React, { Component } from "react";
import { Grid, Image } from "semantic-ui-react";
import { Link } from "react-router-dom";
import { connect } from "react-redux";
import { getLearningEventsIfNeeded } from "../../actions/learningEventActions";

export class TopicContentEventList extends Component {
  componentDidMount() {
    this.eventsList();
  }

  eventsList() {
    this.props.dispatch(
      getLearningEventsIfNeeded(this.props.course_id, this.props.module_id)
    );
  }

  getCustomData(event, field, defaultValue) {
    if (!event || !event.custom_data || !field || !event.custom_data[field]){
      return defaultValue;
    }
    return event.custom_data[field];
  };

  getThumbnail(event){
    const defaultURL = 'https://s3.amazonaws.com/sba-eli-assets-s3-bucket-dev/Platform+Graphics/Case_Study.png';
    const url = this.getCustomData(event, 'thumbnail_url', defaultURL);
    return <Image className={"topic-content-event-grid-icon"} src={url} size={"massive"}/>
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
              className={'icon-column'}
            >
              {this.getThumbnail(event)}
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
              <div className={"topic-content-event-grid-meta"}>
                {this.getCustomData(event, 'event_type', 'Article')} ({this.getCustomData(event, 'time', 'unknown')})
              </div>
            </Grid.Column>
          </Grid>
        );
      });
    } else {
      return null;
    }
  }

  render() {
    const { module_id, course_id } = this.props;
    const learningEvents = this.props.learningEventsCollection[course_id]
      ? this.props.learningEventsCollection[course_id][module_id]
      : [];

    return this.renderEventList(learningEvents);
  }
}

const mapStateToProps = store => {
  return {
    learningEventsCollection: store.learningEvent.learningEventsCollection
  };
};

export default connect(mapStateToProps)(TopicContentEventList);
