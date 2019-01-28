import React from "react";
import { Header, Pagination } from "semantic-ui-react";
import { shallow } from "enzyme";
import { Helmet } from "react-helmet";
import MetaTags from "../../SEO/MetaTags";
import { SearchPage } from "../SearchPage";
import SearchFacets from "../SearchFacets";
import SearchResults from "../SearchResults";

describe("SearchPage", () => {
  it("should render meta tags with Search specific information", () => {
    const wrapper = shallow(
      <SearchPage location={{ search: "" }} dispatch={() => {}} />
    );

    expect(wrapper.find(MetaTags).exists()).toBe(true);
    const metaWrapper = wrapper.find(MetaTags).dive();
    const helmetProps = metaWrapper.find(Helmet).props();

    expect(helmetProps.title).toBe("SBA Search");
    expect(helmetProps.meta[0].name).toBe("description");
    expect(helmetProps.meta[0].content).toBe("Description for the SBA Search");

    //TODO: add Canonical URL validation when we have final urls
  });

  it("should render a <Header> that displays the search term", () => {
    let searchTerm = "leadership";
    let urlString = {
      search:
        "?mediaType=podcast&mediaType=assessment&mediaType=tools&searchTerm=" +
        searchTerm
    };
    const searchMetadata = {
      pagination: {
        current_page: 1,
        next_page: "/uri/to/page",
        previous_page: "/uri/to/page",
        total_pages: 1,
        total_count: 6
      }
    };

    const wrapper = shallow(
      <SearchPage
        location={urlString}
        dispatch={() => {}}
        searchMetadata={searchMetadata}
      />
    );

    expect(wrapper.find(Header).exists()).toBe(true);
    expect(
      wrapper
        .find(Header)
        .render()
        .text()
    ).toBe('6 Search Results for "' + searchTerm + '"');
  });

  it("should render a <Header> that displays text for a single search result", () => {
    let searchTerm = "leadership";
    const searchMetadata = {
      pagination: {
        current_page: 1,
        next_page: "/uri/to/page",
        previous_page: "/uri/to/page",
        total_pages: 1,
        total_count: 1
      }
    };
    const wrapper = shallow(
      <SearchPage
        location={{ search: "?searchTerm=" + searchTerm }}
        dispatch={() => {}}
        searchMetadata={searchMetadata}
      />
    );

    expect(wrapper.find(Header).exists()).toBe(true);
    expect(
      wrapper
        .find(Header)
        .render()
        .text()
    ).toBe('1 Search Result for "' + searchTerm + '"');
  });

  it("should display blank, without an error, if no search term is available", () => {
    let urlString = {
      search:
        "?mediaType=podcast&mediaType=assessment&mediaType=tools&searchTerm="
    };

    const wrapper = shallow(
      <SearchPage location={urlString} dispatch={() => {}} />
    );

    expect(wrapper.find(Header).exists()).toBe(true);
    expect(
      wrapper
        .find(Header)
        .render()
        .text()
    ).toEqual("All Results");
  });

  it("should display blank, without an error, if no search string is available", () => {
    const wrapper = shallow(
      <SearchPage location={{ search: "" }} dispatch={() => {}} />
    );

    expect(wrapper.find(Header).exists()).toBe(true);
    expect(
      wrapper
        .find(Header)
        .render()
        .text()
    ).toEqual("All Results");
  });

  it("should not execute script tags in the search input box", () => {
    let searchTerm = "<script>alert('hello');</script>";
    let urlString = { search: "?searchTerm=" + searchTerm };

    const wrapper = shallow(
      <SearchPage location={urlString} dispatch={() => {}} />
    );

    expect(wrapper.find(Header).exists()).toBe(true);
    expect(
      wrapper
        .find(Header)
        .render()
        .text()
    ).toEqual('No Search Results were found for "' + searchTerm + '"');
  });

  it("should not execute XSS code with single quotes in the search input box", () => {
    let searchTerm = "' onfocus='alert(1)'";
    let displayTerm = "' onfocus";
    let urlString = { search: "?searchTerm=" + searchTerm };

    const wrapper = shallow(
      <SearchPage location={urlString} dispatch={() => {}} />
    );

    expect(wrapper.find(Header).exists()).toBe(true);
    expect(
      wrapper
        .find(Header)
        .render()
        .text()
    ).toEqual('No Search Results were found for "' + displayTerm + '"');
  });

  it("should not execute XSS code with double quotes in the search input box", () => {
    let searchTerm = '" onfocus="alert(1)"';
    let displayTerm = '" onfocus';
    let urlString = { search: "?searchTerm=" + searchTerm };

    const wrapper = shallow(
      <SearchPage location={urlString} dispatch={() => {}} />
    );

    expect(wrapper.find(Header).exists()).toBe(true);
    expect(
      wrapper
        .find(Header)
        .render()
        .text()
    ).toEqual('No Search Results were found for "' + displayTerm + '"');
  });

  it("should render a <SearchFacets> component", () => {
    const wrapper = shallow(
      <SearchPage location={{ search: "" }} dispatch={() => {}} />
    );

    expect(wrapper.find(SearchFacets).exists()).toBe(true);
  });

  it("should render a <SearchResults> component", () => {
    const wrapper = shallow(
      <SearchPage location={{ search: "" }} dispatch={() => {}} />
    );

    expect(wrapper.find(SearchResults).exists()).toBe(true);
  });

  it("should render a <Pagination> component if there is more than 1 page of results", () => {
    const searchMetadata = { pagination: { total_pages: 4 } };
    const wrapper = shallow(
      <SearchPage
        location={{ search: "" }}
        dispatch={() => {}}
        searchMetadata={searchMetadata}
      />
    );
    expect(wrapper.find(Pagination).exists()).toBe(true);
  });

  it("should not render a <Pagination> component if there is 1 page of results", () => {
    const wrapper = shallow(
      <SearchPage location={{ search: "" }} dispatch={() => {}} />
    );
    const searchMetadata = { pagination: { total_pages: 1 } };
    wrapper.instance().setState({ searchMetadata });
    expect(wrapper.find(Pagination).exists()).toBe(false);
  });

  it("should not render a <Pagination> component if there is empty pagination data", () => {
    const wrapper = shallow(
      <SearchPage location={{ search: "" }} dispatch={() => {}} />
    );
    const searchMetadata = { pagination: {} };
    wrapper.instance().setState({ searchMetadata });
    expect(wrapper.find(Pagination).exists()).toBe(false);
  });

  it("should not render a <Pagination> component if there is no pagination data", () => {
    const wrapper = shallow(
      <SearchPage location={{ search: "" }} dispatch={() => {}} />
    );
    const searchMetadata = {};
    wrapper.instance().setState({ searchMetadata });
    expect(wrapper.find(Pagination).exists()).toBe(false);
  });
});
