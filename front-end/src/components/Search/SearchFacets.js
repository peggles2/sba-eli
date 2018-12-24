import React, { Component } from "react";
import { Form, Input } from "semantic-ui-react";
import SubjectFilters from "./SubjectFilters";
import MediaTypeFilters from "./MediaTypeFilters";
import TimeFilters from "./TimeFilters";

export default class SearchFacets extends Component {

  cancelSearch(event) {
    //TODO what do we want the cancel behavior to be?
    event.preventDefault();
    console.log("Cancel Search")
  }

  render() {
    return (
      <Form method="GET" action="/search">
        <Form.Group inline>
          <Form.Group>
            <Form.Field>
              <label>Subject</label>
              <SubjectFilters />
            </Form.Field>
          </Form.Group>
          <Form.Group>
            <Form.Field>
              <label>Media Type</label>
              <MediaTypeFilters />
            </Form.Field>
          </Form.Group>
          <Form.Group>
            <Form.Field>
              <label>Time</label>
              <TimeFilters />
            </Form.Field>
          </Form.Group>
        </Form.Group>
        <Form.Group>
          <Form.Button fluid onClick={this.cancelSearch}>Cancel</Form.Button>
          <Form.Button fluid type="submit">
            Apply
          </Form.Button>
        </Form.Group>
        <Input type="hidden" name="searchTerm" value={this.props.searchTerm} />
      </Form>
    );
  }
}
