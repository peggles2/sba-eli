import React, {Component} from "react";
import "../../App.css";
import "../../assets/style/search.css"
import {Button, Container, Grid, Header, Icon, Pagination, Segment, Sidebar} from "semantic-ui-react";
import axios from "axios";
import queryString from 'query-string';
import SearchFacets from "./SearchFacets";
import SearchResults from "./SearchResults";

export default class SearchPage extends Component {

  constructor(props) {
    super(props);

    let params = queryString.parse(this.props.location.search);

    this.state = {
      searchTerm: this.clean(params.searchTerm),
      urlParams: params,
      visibleDrawer: false,
      searchResults: [],
      searchMetadata: []
    };
  };

  componentDidMount() {
    this.fetchData();
  }

  handleToggle = animation => () =>
      this.setState({animation, visibleDrawer: !this.state.visibleDrawer})

  clean(text) {
    return ((text !== undefined && text.length > 0)
        ? text.trim()
        : '');
  }

  fetchData() {
    let url = process.env.REACT_APP_SERVICE_HOST + "/searches?";

    //TODO: verify that malicious data isn't being passed via the params
    if (this.state.urlParams !== undefined) {
      if (this.state.urlParams.searchTerm !== undefined) {
        url += "keywords=" + this.state.urlParams.searchTerm
      }
      if (this.state.urlParams.subject !== undefined) {
        url += "&subject=" + this.state.urlParams.subject
      }
      if (this.state.urlParams.mediaType !== undefined) {
        url += "&media_types=" + this.state.urlParams.mediaType
      }
      if (this.state.urlParams.time !== undefined) {
        url += "&duration=" + this.state.urlParams.time
      }
    }

    axios
        .get(encodeURI(url))
        .then(res => {
          const searchResultsResponse = res.data;
          if (searchResultsResponse) {
            const searchResults = searchResultsResponse.data;
            const searchMetadata = searchResultsResponse.meta;
            this.setState({searchResults});
            this.setState({searchMetadata});
          } else {
            console.error(searchResultsResponse);
          }
        })
        .catch(error => {
          console.error(error);
        });

    //TODO: static results should be removed when API is finalized
    const searchResults = [
      {
        "id": 1,
        "name": "Title of a learning path",
        "description": "Short description of the content",
        "content_type": "learning-path",
        "meta_data": {},
        "thumbnail": "http://picsum.photos/200"
      },
      {
        "id": 1,
        "name": "Title of a learning objective",
        "description": "Sesame snaps tart pastry sweet roll cupcake. Chocolate bar jelly beans cheesecake cake cupcake. Liquorice icing tootsie roll chupa chupsfruitcake gingerbread. Sesame snaps tart pastry sweet roll cupcake. Sesame snaps tart pastry sweet roll cupcake. Sesame snaps tart pastry sweet roll cupcake. Chocolate bar jelly beans cheesecake cake cupcake. Liquorice icing tootsie roll chupa chupsfruitcake gingerbread. Sesame snaps tart pastry sweet roll cupcake. Sesame snaps tart pastry sweet roll cupcake.",
        "content_type": "learning-objective",
        "meta_data": {
          "learning_path_id": 1
        },
        "thumbnail": "http://picsum.photos/200"
      },
      {
        "id": 2,
        "name": "Title of Learning Event",
        "description": "Short description of the content",
        "content_type": "learning-event",
        "meta_data": {
          "learning_path_id": 1,
          "learning_objective_id": 1
        },
        "thumbnail": "http://picsum.photos/200"
      }
    ]
    //TODO: static results should be removed when API is finalized
    const searchMetadata = {
      "pagination": {
        "current_page": 1,
        "total_pages": 2,
        "total_count": 10
      }
    }
    //TODO: should be removed when API is finalized
    this.setState({searchResults});
    //TODO: should be removed when API is finalized
    this.setState({searchMetadata});
  }

  searchText() {
    //TODO: what is the correct text for these states?
    if (this.state.searchTerm !== undefined
        && this.state.searchTerm !== '') {
      if (this.state.searchMetadata
          && this.state.searchMetadata.pagination
          && this.state.searchMetadata.pagination.total_count
          && this.state.searchMetadata.pagination.total_count > 0) {
        return `${this.state.searchMetadata.pagination.total_count} Search Results for "${this.state.searchTerm}"`
      }
      //TODO: nothing to filter so hide the filter button
      return `No Search Results were found for "${this.state.searchTerm}"`
    }
    //TODO: nothing to filter so hide the filter button
    return 'No search term entered'
  }

  getPagination() {
    if (this.state.searchMetadata
        && this.state.searchMetadata.pagination
        && this.state.searchMetadata.pagination.total_pages
        && this.state.searchMetadata.pagination.total_pages > 1) {
      return <Pagination
                boundaryRange={0}
                ellipsisItem={null}
                prevItem={null}
                nextItem={null}
                firstItem={null}
                lastItem={null}
                activePage={this.state.searchMetadata.pagination.current_page}
                siblingRange={1}
                totalPages={this.state.searchMetadata.pagination.total_pages}
            />
    }
  }

  render() {
    const {visibleDrawer} = this.state

    return (
        <Container className='search_page'>
          <Grid.Row className='search_page_header'>
            <Header as='h1'>{this.searchText()}</Header>
            <Button icon labelPosition='left'
                    basic floated='right'
                    type='submit'
                    id='add_filters'
                    onClick={this.handleToggle('HELLO')}>
              <Icon name='sliders'/>
              Add Filters
            </Button>
          </Grid.Row>
          <Grid.Row>
            <Sidebar.Pushable>
              <Sidebar as={Segment} animation='overlay' direction='top' visible={visibleDrawer}>
                <SearchFacets urlParams={this.state.urlParams}/>
              </Sidebar>
              <Sidebar.Pusher>
                <SearchResults searchResults={this.state.searchResults}/>
              </Sidebar.Pusher>
            </Sidebar.Pushable>
          </Grid.Row>
          <Grid.Row>
            {this.getPagination()}
          </Grid.Row>
        </Container>
    )
  }
}
