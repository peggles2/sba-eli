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
    expect(wrapper.find('title').text()).toBe("Small Business Administration: Women Entrepreneurs");
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
    var canonicalUrl = "https://sba.gov/eli/new_value"
    const wrapper = shallow(<MetaTags canonicalUrl={canonicalUrl} />);
    expect(wrapper.find("link[rel='canonical']").props().href).toBe(canonicalUrl)
  });
  
  it('should render default open graph tags', () => {
    const wrapper = shallow(<MetaTags />);
    expect(wrapper.find("meta[property='og:title']").length).toEqual(1);
    expect(wrapper.find("meta[property='og:title']").props().content).toBe("Small Business Administration: Women Entrepreneurs");
    expect(wrapper.find("meta[property='og:description']").exists()).toBe(true);
    expect(wrapper.find("meta[property='og:description']").props().content).toBe("We support America's small businesses. The SBA connects entrepreneurs with lenders and funding to help them plan, start and grow their business.")
    expect(wrapper.find("meta[property='og:type']").props().content).toBe("website");
    expect(wrapper.find("meta[property='og:image']").exists()).toBe(true);
    expect(wrapper.find("meta[property='og:image']").props().content).toBe('https://picsum.photos/200/300/?random');
    expect(wrapper.find("meta[property='og:url']").props().content).toBe('https://sba.gov/eli');
  });

  it('should overwrite the default open graph title tag', () => {
    var newTitle = "This is a title that wasn't there before"
    const wrapper = shallow(<MetaTags metaTitle={newTitle} />);
    expect(wrapper.find("meta[property='og:title']").length).toEqual(1);
    expect(wrapper.find("meta[property='og:title']").props().content).toBe(newTitle)
  });

  it('should overwrite the default open graph description tag', () => {
    var newDescription = "this is a new and different description"
    const wrapper = shallow(<MetaTags metaDescription={newDescription} />);
    expect(wrapper.find("meta[property='og:description']").exists()).toBe(true);
    expect(wrapper.find("meta[property='og:description']").props().content).toBe(newDescription);
  });

  it('should overwrite the default open graph image tag', () => {
    var newImageUrl = "https://picsum.photos/200"
    const wrapper = shallow(<MetaTags metaImage={newImageUrl} />);
    expect(wrapper.find("meta[property='og:image']").exists()).toBe(true);
    expect(wrapper.find("meta[property='og:image']").props().content).toBe(newImageUrl);
    });

  it('should insert an open graph url', () => {
    var canonicalUrl = "https://sba.gov/eli/new_value"
    const wrapper = shallow(<MetaTags canonicalUrl={canonicalUrl} />);
    expect(wrapper.find("meta[property='og:url']").props().content).toBe(canonicalUrl)
  });
});
