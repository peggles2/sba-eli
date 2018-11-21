import React, { Component } from "react";
import axios from "axios";
import { Header, Card } from "semantic-ui-react";

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
      <div>
        <Card>
          <Card.Content>
            <Card.Header>
              {event.title} {event.id}
            </Card.Header>
            <Card.Meta>{event.type}</Card.Meta>
          </Card.Content>
          <Card.Content extra>
            <Header as="h5">Url:</Header> {event.url}
            <Header as="h5">HTML Url:</Header> {event.html_url}
          </Card.Content>
        </Card>
      </div>
    );
  }
}
