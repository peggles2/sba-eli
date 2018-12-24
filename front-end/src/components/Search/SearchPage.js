import React, {Component} from "react";
import "../../App.css";
import {Container, Header} from "semantic-ui-react";
import queryString from 'query-string';
import SearchFacets from "./SearchFacets";
import SearchResults from "./SearchResults";

export default class SearchPage extends Component {
  render() {
    let params = queryString.parse(this.props.location.search);
    //TODO: does this need to be sanitized?
    let searchTerm = params.searchTerm

    return (
        <div>
          <Container>
              <Header as='h1'>Search Results for '{searchTerm}'</Header>
          </Container>
          <Container>
            <SearchFacets searchTerm={searchTerm}/>
          </Container>
          <Container>
            <SearchResults/>
          </Container>
        </div>
    )
  }
}
