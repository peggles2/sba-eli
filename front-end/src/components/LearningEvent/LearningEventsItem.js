import React, { Component } from "react";
import { List } from "semantic-ui-react";

export default class LearningEventsItem extends Component {
  render() {
    return <List.Item>{this.props.item.title}</List.Item>;
  }
}
