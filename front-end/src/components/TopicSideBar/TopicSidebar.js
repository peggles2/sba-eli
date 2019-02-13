import React, { Component } from "react";
import { Accordion, Container, Icon } from "semantic-ui-react";
import TopicEventList from "./TopicEventList";
import TopicProgress from "./TopicProgress";
import "./TopicSidebar.scss";

export default class TopicSideBar extends Component {
  constructor(props) {
    super(props);

    this.state = {
      activeIndex: 0
    };
  }

  handleClick = (e, titleProps) => {
    const { index } = titleProps;
    const { activeIndex } = this.state.activeIndex;
    const newIndex = activeIndex === index ? -1 : index;

    this.setState({ activeIndex: newIndex });
  };

  renderTopicsList(topics = []) {
    const { activeIndex } = this.state;
    const { event_id } = this.props;
    let topicsComplete = 0;
    if (topics.length) {
      return (
        <Container fluid className={"topic-container"}>
          <Accordion>
            {topics.map((topic, idx) => {
              let topicCircle = idx + 1;
              if (topic.completed_at) {
                topicsComplete++;
                topicCircle = <Icon name="checkmark" />;
              }
              return (
                <React.Fragment key={"topicSidebar" + idx}>
                  <Accordion.Title
                    active={activeIndex === idx}
                    index={idx}
                    onClick={this.handleClick}
                    className={"topic-accordion-title"}
                  >
                    <div className={"topic-number-circle"}>{topicCircle}</div>
                    {topic.name}
                  </Accordion.Title>
                  <Accordion.Content
                    active={activeIndex === idx}
                    className={"topic-accordion-content"}
                  >
                    <TopicEventList
                      course_id={this.props.course_id}
                      module_id={topic.id}
                      event_id={event_id}
                    />
                  </Accordion.Content>
                </React.Fragment>
              );
            })}
          </Accordion>

          <TopicProgress
            course_id={this.props.course_id}
            topicsComplete={topicsComplete}
            topicsTotal={topics.length}
          />
        </Container>
      );
    }
    return null;
  }

  render() {
    return this.renderTopicsList(this.props.topicsList);
  }
}
