import React from 'react';
import {shallow} from 'enzyme';
import {Helmet} from "react-helmet";
import MetaTags from '../MetaTags';

describe('MetaTags', () => {

  it('should render a <Helmet> Tag', () => {
    const wrapper = shallow(<MetaTags />);
    expect(wrapper.find(Helmet).exists()).toBe(true);
  });

  it('should render default meta tags', () => {
    const wrapper = shallow(<MetaTags />);
    expect(wrapper.find('title').length).toEqual(1);
    expect(wrapper.find('title').text()).toBe("Small Business Administration: Women Entrepreneurs")
    expect(wrapper.find("meta[name='author']").exists()).toBe(false);
    expect(wrapper.find("meta[name='description']").exists()).toBe(true);
    expect(wrapper.find("meta[name='description']").props().content).toBe("We support America's small businesses. The SBA connects entrepreneurs with lenders and funding to help them plan, start and grow their business.")
  });

  it('should overwrite the default title tag', () => {
    var newTitle = "This is a title that wasn't there before"
    const wrapper = shallow(<MetaTags metaTitle={newTitle} />);
    expect(wrapper.find('title').length).toEqual(1);
    expect(wrapper.find('title').text()).toBe(newTitle)
  });

  it('should overwrite the default description tag', () => {
    var newDescription = "this is a new and different description"
    const wrapper = shallow(<MetaTags metaDescription={newDescription} />);
    expect(wrapper.find("meta[name='description']").exists()).toBe(true);
    expect(wrapper.find("meta[name='description']").props().content).toBe(newDescription);
  });

  it('should insert an author tag', () => {
    var newAuthor = "Scrooge McDuck"
    const wrapper = shallow(<MetaTags metaAuthor={newAuthor} />);
    expect(wrapper.find("meta[name='author']").exists()).toBe(true);
    expect(wrapper.find("meta[name='author']").props().content).toBe(newAuthor)
  });

  it('should insert a canonical url', () => {
    var canonicalUrl = "https://sba.gov/eli"
    const wrapper = shallow(<MetaTags canonicalUrl={canonicalUrl} />);
    expect(wrapper.find("link[rel='canonical']").props().href).toBe(canonicalUrl)
  });
  
});
