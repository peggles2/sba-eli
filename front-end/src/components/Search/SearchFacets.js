import React, { Component } from "react";
import {Label, Form, Input } from "semantic-ui-react";
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
              <Label>Media Type</Label>
              <MediaTypeFilters filters={this.props.urlParams.mediaType} />
            </Form.Field>
          </Form.Group>
          <Form.Group>
            <Form.Field>
              <Label>Subject</Label>
              <SubjectFilters filters={this.props.urlParams.subject} />
            </Form.Field>
          </Form.Group>
          <Form.Group>
            <Form.Field>
              <Label>Time</Label>
              <TimeFilters filters={this.props.urlParams.time} />
            </Form.Field>
          </Form.Group>
        </Form.Group>
        <Form.Group>
          <Form.Button fluid id='cancel_search' onClick={this.cancelSearch}>
            Reset
          </Form.Button>
          <Form.Button fluid type='submit' id='submit_search'>
            Apply
          </Form.Button>
        </Form.Group>
        <Input type="hidden" name="searchTerm" value={this.props.urlParams.searchTerm} />
      </Form>
    );
  }
}
