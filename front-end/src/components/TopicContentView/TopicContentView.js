import React, { Component } from "react";
import { Item } from "semantic-ui-react";
import TopicContentEventList from "./TopicContentEventList";

export default class TopicContentView extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  renderTopicsList(topicsList) {
    if (topicsList.length) {
      return topicsList.map(topic => {
        return (
          <div
            key={"topicContentView" + topic.id}
            style={{
              marginBottom: "20px",
              border: "1px solid rgba(34,36,38,.15)"
            }}
          >
            <Item.Group>
              <Item>
                <Item.Image src="https://via.placeholder.com/350" />

                <Item.Content>
                  <Item.Header style={{ paddingTop: "20px" }}>
                    {topic.name}
                  </Item.Header>
                  <Item.Meta># of Learning Events (Time)</Item.Meta>
                  <Item.Description>
                    This is a desciption for the Topic: {topic.name}
                  </Item.Description>
                </Item.Content>
              </Item>
            </Item.Group>

            <TopicContentEventList
              course_id={this.props.course_id}
              module_id={topic.id}
            />
          </div>
        );
      });
    } else {
      return <div />;
    }
  }

  render() {
    return this.renderTopicsList(this.props.topicsList);
  }
}
