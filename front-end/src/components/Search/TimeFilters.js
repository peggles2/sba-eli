import React, { Component } from "react";
import { Form } from "semantic-ui-react";

export default class TimeFilters extends Component {
  render() {
    //TODO: should this be dynamic?
    const staticTimeFilters = [
      { key: "short", text: "Less than 1 minute" },
      { key: "medium", text: "2 - 5 minutes" },
      { key: "long", text: "5 minutes +" }
    ];

    return staticTimeFilters.map(filter => {
      let selected = false
      if (this.props.filters !== undefined
          && this.props.filters.includes(filter.key)) {
        selected = true
      }

      return (
        <Form.Checkbox
          name="time"
          value={filter.key}
          key={filter.key}
          id={'time_filter_'  + filter.key}
          label={{ children: filter.text }}
          defaultChecked={selected}
        />
      );
    });
  }
}
