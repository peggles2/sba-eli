import React from 'react';
import App from './App';
import {shallow} from 'enzyme';
import MetaTags from './components/SEO/MetaTags';
import Navigation from './components/Navigation/Navigation';

describe('App', () => {

  it('should render a <MetaTag> tag', () => {
    const wrapper = shallow(<App />);
    expect(wrapper.find(MetaTags).exists()).toBe(true);
  });

  it('should render a <Navigation> tag', () => {
    const wrapper = shallow(<App />);
    expect(wrapper.find(Navigation).exists()).toBe(true);
  });
});


