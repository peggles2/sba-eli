
import "./learningEvent.css";
import React, { Component } from "react";
import { Header, Container } from "semantic-ui-react";
import axios from "axios";
import LearningEventManager from "./LearningEventManager";
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
  }

  render() {
    const event = this.state.learningEvent;

    return (
      <Container>
        <MetaTags metaTitle={event.title}
                metaDescription={event.description}
                canonicalUrl=""/>
        <Header as="h1">{event.title}</Header>
        <LearningEventManager event={event} />
      </Container>
    );
  }
}
