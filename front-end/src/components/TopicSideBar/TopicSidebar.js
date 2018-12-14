import React, { Component } from "react";
import { Accordion, Icon } from "semantic-ui-react";
import TopicEventList from "./TopicEventList";

export default class TopicSideBar extends Component {
  constructor(props) {
    super(props);

    this.state = {
      //topicsList: [],
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
      return objectives.map((objective, i) => {
        return (
          <React.Fragment key={"topicSidebar" + i}>
            <Accordion.Title
              active={activeIndex === i}
              index={i}
              onClick={this.handleClick}
            >
              <Icon name="dropdown" />
              {objective.name}
            </Accordion.Title>
            <Accordion.Content active={activeIndex === i}>
              <TopicEventList
                course_id={this.props.course_id}
                module_id={objective.id}
              />
            </Accordion.Content>
          </React.Fragment>
        );
      });
    }
    return (
      <div>
        <Accordion.Title>No Data</Accordion.Title>
        <Accordion.Content>Test Content</Accordion.Content>
      </div>
    );
  }

  render() {
    return (
      <Accordion styled>
        {this.renderTopicsList(this.props.topicsList)}
      </Accordion>
    );
  }
}
