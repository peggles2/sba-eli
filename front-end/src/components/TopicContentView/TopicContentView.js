import React, { Component } from "react";
import { Item, Divider, Button, Icon, Dropdown } from "semantic-ui-react";
import TopicContentEventList from "./TopicContentEventList";
import "./topicContentView.css";
import TopicContentItem from "./TopicContentItem";

export default class TopicContentView extends Component {
  renderTopicSelect() {
    if (this.props.topicsList.length) {
      const topics = this.props.topicsList;
      const options = topics.map((topic, idx) => {
        return {
          key: topic.id,
          value: "topic" + topic.id.toString(),
          text: topic.name
        };
      });

      return (
        <div className={"mobile only topic-content-select"}>
          <Dropdown
            placeholder={"Select a Topic..."}
            options={options}
            selection
            fluid
            onChange={this.handleChange}
          />
        </div>
      );
    } else {
      return null;
    }
  }

  renderTopicsList(topicsList) {
    if (topicsList.length) {
      return topicsList.map((topic, idx) => {
        let ref = "topic" + topic.id.toString();
        this[ref] = React.createRef();
        return (
          <div
            key={"topicContentView" + topic.id}
            className={"topic-content-view"}
            ref={this[ref]}
          >
            <TopicContentItem topic={topic} course_id={this.props.course_id} />
          </div>
        );
      });
    } else {
      return <div />;
    }
  }

  scrollToTopic(ref) {
    this[ref].current.scrollIntoView({ behavior: "smooth", block: "start" });
  }
  handleChange = (e, { name, value }) => this.scrollToTopic(value);

  render() {
    return (
      <React.Fragment>
        {this.renderTopicSelect()}
        {this.renderTopicsList(this.props.topicsList)}
      </React.Fragment>
    );
  }
}
