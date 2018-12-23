import React, { Component } from "react";
import { Container } from "semantic-ui-react";
import axios from "axios";
import LearningEventHeader from "./LearningEventHeader"
import LearningEventManager from "./LearningEventManager";
import LearningEventFooter from "./LearningEventFooter";
import { Header, Container, Divider } from "semantic-ui-react";
import LearningEventFooter from "./LearningEventFooter";
import "./LearningEvent.scss";
import MetaTags from '../SEO/MetaTags'

export default class LearningEvent extends Component {
  constructor(props) {
    super(props);

    this.state = {
      learningEvent: {}
    };
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
    const url2 =
      process.env.REACT_APP_SERVICE_HOST + `/learning_events/`;

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

    return (
      <Container className="learning-event-container">
        <MetaTags metaTitle={event.title}
                metaDescription={event.description}
                canonicalUrl=""/>
        <LearningEventHeader event={event} />
        <LearningEventManager event={event} />
        <Divider />
        <LearningEventFooter courseId={this.props.match.params.course_id} module={this.state.learningModule} event={this.state.learningEvent}/>
      </Container>
    );
  }
}
