import React, {Component} from "react";
import {Button, Grid, Header, Icon, Pagination, Segment, Sidebar} from "semantic-ui-react";
import queryString from 'query-string';
import SearchFacets from "./SearchFacets";
import SearchResults from "./SearchResults";
import MetaTags from '../SEO/MetaTags'

import { connect } from "react-redux";
import { search } from '../../actions/searchActions';

import "./search.scss";
export class SearchPage extends Component {

  constructor(props) {
    super(props);

    let params = queryString.parse(this.props.location.search);

    this.state = {
      searchTerm: this.clean(params.searchTerm),
      urlParams: params,
      visibleDrawer: false
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
    this.props.dispatch(search(
      this.state.urlParams && this.state.urlParams.searchTerm
        ? this.state.urlParams.searchTerm 
        : '',
      this.state.urlParams && this.state.urlParams.subject
        ? this.state.urlParams.subject 
        : '',
      this.state.urlParams && this.state.urlParams.mediaType
        ? this.state.urlParams.mediaType 
        : '',
      this.state.urlParams && this.state.urlParams.time
        ? this.state.urlParams.time 
        : '',
      20
    ));
  }

  searchText() {
    //TODO: what is the correct text for these states?
    if (this.state.searchTerm !== undefined
        && this.state.searchTerm !== '') {
      if (this.props.searchMetadata
          && this.props.searchMetadata.pagination
          && this.props.searchMetadata.pagination.total_count
          && this.props.searchMetadata.pagination.total_count > 0) {
        return this.props.searchMetadata.pagination.total_count === 1 
              ? `1 Search Result for "${this.state.searchTerm}"`
              : `${this.props.searchMetadata.pagination.total_count} Search Results for "${this.state.searchTerm}"`
      }
      return `No Search Results were found for "${this.state.searchTerm}"`
    }
    return 'All Results'
  }

  getPagination() {
    if (this.props.searchMetadata
        && this.props.searchMetadata.pagination
        && this.props.searchMetadata.pagination.total_pages
        && this.props.searchMetadata.pagination.total_pages > 1) {
      return <Pagination
                boundaryRange={0}
                ellipsisItem={null}
                prevItem={null}
                nextItem={null}
                firstItem={null}
                lastItem={null}
                activePage={this.props.searchMetadata.pagination.current_page}
                siblingRange={1}
                totalPages={this.props.searchMetadata.pagination.total_pages}
            />
    }
  }

  render() {
    const {visibleDrawer} = this.state

    return (
        <Grid stackable className='search_page'>
        <MetaTags metaTitle="SBA Search"
                metaDescription="Description for the SBA Search"
                canonicalUrl="https://sba.gov/search" />
          <Grid.Row centered className='search_page_header'>
              <Grid.Column width={12}>
                <Header tabIndex="0" as='h1'>{this.searchText()}</Header>
              </Grid.Column>
              <Grid.Column width={3}>
                <Button icon labelPosition='left'
                        basic
                        type='submit'
                        id='add_filters'
                        onClick={this.handleToggle('HELLO')}>
                  <Icon name='sliders'/>
                  <span>Add Filters</span>
                </Button>
              </Grid.Column>
          </Grid.Row>
          <Grid.Row centered className="search_results">
            <Grid.Column width={14}>
              <Sidebar.Pushable>
                <Sidebar as={Segment} animation='overlay' direction='top' visible={visibleDrawer}>
                  <SearchFacets urlParams={this.state.urlParams}/>
                </Sidebar>
                <Sidebar.Pusher>
                  <SearchResults searchResults={this.props.searchResults}/>
                </Sidebar.Pusher>
              </Sidebar.Pushable>
            </Grid.Column>
          </Grid.Row>
          <Grid.Row centered>
              {this.getPagination()}
          </Grid.Row>
        </Grid>
    )
  }
}

const mapStateToProps = store => {
  return {
    searchResults: store.search.searchResults,
    searchMetadata: store.search.searchMetadata
  };
};

export default connect(mapStateToProps)(SearchPage);


