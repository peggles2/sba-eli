import React from 'react';
import { BrowserRouter as Router,Link } from 'react-router-dom';
import { Button, Menu, Dropdown } from 'semantic-ui-react';
import Navbar from '../Navbar';
import NavigationLearningPath from '../NavigationLearningPath';
import { shallow, mount } from 'enzyme';

describe('Navbar', () => {

  it('should render a <Menu>', () => {
    const wrapper = shallow(<Navbar/>);

    expect(wrapper.find(Menu).length).toEqual(1);
    expect(wrapper.find(Menu.Menu).exists()).toBe(true);
  });

  it('should render a <Dropdown> of all learning paths', () => {
    const wrapper = shallow(<Navbar/>);

    expect(wrapper.find(Dropdown).length).toEqual(1);
    expect(wrapper.find(Dropdown.Menu).length).toEqual(1);
    expect(wrapper.find(NavigationLearningPath).length).toEqual(1);
  });

  it('should render a Login button', () => {
    const wrapper = mount(<Router><Navbar/></Router>);

    expect(wrapper.find(Link).exists()).toBe(true);
  });

  it('should render a Register button', () => {
    const wrapper = mount(<Router><Navbar/></Router>);

    expect(wrapper.find(Link).exists()).toBe(true);
  });
});
