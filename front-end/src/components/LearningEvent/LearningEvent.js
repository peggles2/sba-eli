import React, { Component } from "react";
import axios from "axios";
import LearningEventHeader from "./LearningEventHeader";
import LearningEventManager from "./LearningEventManager";
import LearningEventFooter from "./LearningEventFooter";
import { Container, Divider } from "semantic-ui-react";
import "./LearningEvent.scss";
import MetaTags from "../SEO/MetaTags";
import LearningEventDiscussion from "../Discussion/LearningEventDiscussion";

export default class LearningEvent extends Component {
  constructor(props) {
    super(props);

    this.state = {
      learningEvent: {}
    };
  }

  static getEventPath(course_id, module_id, event_id) {
    return (
      `/learning_paths/${course_id}` +
      `/learning_objectives/${module_id}` +
      `/learning_events/${event_id}`
    );
  }

  componentDidMount() {
    this.setLearningEvent();
  }

  componentWillReceiveProps(newProps) {
    //Added this to account for react routing not updating with different props
    if (this.props !== newProps) {
      this.props = newProps;
      this.setLearningEvent();
    }
  }

  setLearningEvent() {
    const { course_id, module_id, id: event_id } = this.props.match.params;
    const url =
      process.env.REACT_APP_SERVICE_HOST + `/learning_events/${event_id}`;
    const url2 = process.env.REACT_APP_SERVICE_HOST + `/learning_events/`;

    const eventParams = {
      course_id,
      module_id
    };

    axios
      .get(url, { params: eventParams })
      .then(res => {
        const learningEvent = res.data;
        this.setState({ learningEvent });
      })
      .catch(error => {
        console.log(error);
      });

    axios
      .get(url2, { params: eventParams })
      .then(res => {
        const learningModule = res.data;
        this.setState({ learningModule });
      })
      .catch(error => {
        console.log(error);
      });
  }

  render() {
    const event = this.state.learningEvent;
    const topicTitle = this.props.topicTitle;
    return (
      <div>
      <Container className="learning-event-container">
        <MetaTags
          metaTitle={event.title}
          metaDescription={event.description}
          canonicalUrl=""
        />
        <LearningEventHeader event={event} topicTitle={topicTitle} />
        <LearningEventManager event={event} />
        <Divider />
        <LearningEventFooter
          courseId={this.props.match.params.course_id}
          module={this.state.learningModule}
          event={this.state.learningEvent}
        />
      </Container>
      <LearningEventDiscussion parent_content_type={event.type} parent_id={event.id} />
      </div>
    );
  }
}
