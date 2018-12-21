import React, { Component } from "react";
import TopicContentEventList from "./TopicContentEventList";
import { Item, Button, Icon, Divider, Accordion } from "semantic-ui-react";

export default class TopicContentItem extends Component {
  state = { listVisible: true, activeIndex: 0 };

  //Using this as a collapse element, no other option in semantic. Open sets the index of accordion
  //to only element, -1 is closed.
  toggleListVisibility = () => {
    const listVisible = !this.state.listVisible;
    this.setState({ listVisible });

    if (listVisible) {
      this.setState({ activeIndex: 0 });
    } else {
      this.setState({ activeIndex: -1 });
    }
  };

  render() {
    const { topic, course_id } = this.props;
    const { listVisible, activeIndex } = this.state;

    return (
      <React.Fragment>
        <Item.Group className={"topic-content-item-group"}>
          <Item className="topic-content-item">
            <Item.Image
              src="https://via.placeholder.com/400"
              className={"computer large screen widescreen only"}
            />

            <Item.Content>
              <Item.Header className={"topic-content-item-header"}>
                {topic.name}
              </Item.Header>
              <Item.Meta># of Learning Events (Time)</Item.Meta>
              <Item.Description>
                This is a desciption for the Topic: {topic.name}
              </Item.Description>
              <Divider />

              <Button
                icon
                className={"topic-content-collapse-button mobile only"}
                onClick={this.toggleListVisibility}
              >
                <Icon name={listVisible ? "chevron up" : "chevron down"} />
              </Button>
              <Button icon className={"topic-content-share-button"}>
                <Icon name={"share"} />
              </Button>
            </Item.Content>
          </Item>
        </Item.Group>

        <Accordion>
          {/* Title is a hidden element, needed for accordion collapse to function */}
          <Accordion.Title
            className={"events-list-accordion-title"}
            active={activeIndex === 0}
            index={0}
          >
            Learning Events for {topic.name}
          </Accordion.Title>
          <Accordion.Content active={activeIndex === 0}>
            <TopicContentEventList course_id={course_id} module_id={topic.id} />
          </Accordion.Content>
        </Accordion>
      </React.Fragment>
    );
  }
}