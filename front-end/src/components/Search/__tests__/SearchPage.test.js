import React from 'react';
import {Header, Pagination} from "semantic-ui-react";
import {shallow, mount} from 'enzyme';
import SearchPage from "../SearchPage";
import SearchFacets from "../SearchFacets";
import SearchResults from "../SearchResults";

describe('SearchPage', () => {

  it('should render an <Header> that dislpays the search term', () => {
    let searchTerm = "hello world"
    let urlString = {search: "?mediaType=podcast&mediaType=assessment&mediaType=tools&searchTerm=" + searchTerm}

    const wrapper = shallow(<SearchPage location={urlString}/>);

    expect(wrapper.find(Header).exists()).toBe(true);
    expect(wrapper.find(Header).render().text()).toEqual("10 Search Results for \"" + searchTerm + "\"");
  });

  it('should display blank, without an error, if no search term is available', () => {
    let urlString = {search: "?mediaType=podcast&mediaType=assessment&mediaType=tools&searchTerm="}

    const wrapper = shallow(<SearchPage location={urlString}/>);

    expect(wrapper.find(Header).exists()).toBe(true);
    expect(wrapper.find(Header).render().text()).toEqual("All Results");
  });

  it('should display blank, without an error, if no search string is available', () => {
    const wrapper = shallow(<SearchPage location={{search: ''}}/>);

    expect(wrapper.find(Header).exists()).toBe(true);
    expect(wrapper.find(Header).render().text()).toEqual("All Results");
  });

  it('should not execute script tags in the search input box', () => {
    let searchTerm = "<script>alert('hello');</script>"
    let urlString = {search: "?searchTerm=" + searchTerm}

    const wrapper = shallow(<SearchPage location={urlString}/>);

    expect(wrapper.find(Header).exists()).toBe(true);
    expect(wrapper.find(Header).render().text()).toEqual("10 Search Results for \"" + searchTerm + "\"");
  });

  it('should not execute XSS code with single quotes in the search input box', () => {
    let searchTerm = "' onfocus='alert(1)'"
    let displayTerm = "' onfocus"
    let urlString = {search: "?searchTerm=" + searchTerm}

    const wrapper = shallow(<SearchPage location={urlString}/>);

    expect(wrapper.find(Header).exists()).toBe(true);
    expect(wrapper.find(Header).render().text()).toEqual("10 Search Results for \"" + displayTerm + "\"");
  });

  it('should not execute XSS code with double quotes in the search input box', () => {
    let searchTerm = '" onfocus="alert(1)"'
    let displayTerm = '" onfocus'
    let urlString = {search: "?searchTerm=" + searchTerm}

    const wrapper = shallow(<SearchPage location={urlString}/>);

    expect(wrapper.find(Header).exists()).toBe(true);
    expect(wrapper.find(Header).render().text()).toEqual("10 Search Results for \"" + displayTerm + "\"");
  });

  it('should render a <SearchFacets> component', () => {
    const wrapper = shallow(<SearchPage location={{search: ''}}/>);

    expect(wrapper.find(SearchFacets).exists()).toBe(true);
  });

  it('should render a <SearchResults> component', () => {
    const wrapper = shallow(<SearchPage location={{search: ''}}/>);

    expect(wrapper.find(SearchResults).exists()).toBe(true);
  });

  it('should render a <Pagination> component if there is more than 1 page of results', () => {
    const wrapper = shallow(<SearchPage location={{search: ''}} searchMetadata={{pagination: {total_pages: 4}}} />);
    expect(wrapper.find(Pagination).exists()).toBe(true);
  });

  it('should not render a <Pagination> component if there is 1 page of results', () => {
    //TODO: add mock results
    /*const wrapper = shallow(<SearchPage location={{search: ''}} searchMetadata={{pagination: {total_pages: 1}}} />);
    expect(wrapper.find(Pagination).exists()).toBe(false);*/
  });

  it('should not render a <Pagination> component if there is empty pagination data', () => {
    //TODO: add mock results
    /*const wrapper = shallow(<SearchPage location={{search: ''}} searchMetadata={{pagination: {}}} />);
    expect(wrapper.find(Pagination).exists()).toBe(false);*/
  });

  it('should not render a <Pagination> component if there is no pagination data', () => {
    //TODO: add mock results
    /*const wrapper = shallow(<SearchPage location={{search: ''}} searchMetadata={{}} />);
    expect(wrapper.find(Pagination).exists()).toBe(false);*/
  });

});
