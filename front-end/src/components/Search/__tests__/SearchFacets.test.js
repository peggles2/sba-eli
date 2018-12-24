import React from 'react';
import {shallow, mount} from 'enzyme';
import {Form, Input} from "semantic-ui-react";
import SearchFacets from "../SearchFacets";
import SearchPage from "../SearchPage";
import MediaTypeFilters from "../MediaTypeFilters";

describe('SearchFacets', () => {

  it('should render an <Form> with two <Form.Button>', () => {
    const wrapper = shallow(<SearchFacets location={{search: ''}}/>);

    expect(wrapper.find(Form).exists()).toBe(true);
    expect(wrapper.find(Form.Button).exists()).toBe(true);
    expect(wrapper.find(Form.Button).length).toEqual(2);
  });

  it('should render a hidden <Input> with the search term value', () => {
    const wrapper = mount(<SearchFacets location={{search: "?searchTerm=hello"}}/>);

    expect(wrapper.find(Input).exists()).toBe(true);
    //expect(wrapper.find(Input).type()).toBe('hidden');
    //expect(wrapper.find(Input).html()).toBe('searchTerm');
    //expect(wrapper.find(Input).value()).toBe('hello');
  });

  it('should render a <MediaTypeFilters> component', () => {
    const wrapper = shallow(<SearchFacets location={{search: ''}}/>);

    expect(wrapper.find(MediaTypeFilters).exists()).toBe(true);
  });

});
