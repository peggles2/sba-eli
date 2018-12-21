import React, { Component } from "react";
import { Accordion, Container } from "semantic-ui-react";
import TopicEventList from "./TopicEventList";
import TopicProgress from "./TopicProgress";
import "./TopicSideBar.scss";

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

  renderTopicsList(objectives = []) {
    const { activeIndex } = this.state;

    if (objectives.length) {
      return (
        <Container fluid className={"topic-container"}>
          <Accordion>
            {objectives.map((objective, idx) => {
              return (
                <React.Fragment key={"topicSidebar" + idx}>
                  <Accordion.Title
                    active={activeIndex === idx}
                    index={idx}
                    onClick={this.handleClick}
                    className={"topic-accordion-title"}
                  >
                    <div className={"topic-number-circle"}>{idx + 1}</div>
                    {objective.name}
                  </Accordion.Title>
                  <Accordion.Content
                    active={activeIndex === idx}
                    className={"topic-accordion-content"}
                  >
                    <TopicEventList
                      course_id={this.props.course_id}
                      module_id={objective.id}
                    />
                  </Accordion.Content>
                </React.Fragment>
              );
            })}
          </Accordion>
          <TopicProgress />
        </Container>
      );
    }
    return null;
  }

  render() {
    return this.renderTopicsList(this.props.topicsList);
  }
}
