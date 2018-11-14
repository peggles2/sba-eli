import React from 'react';
import ReactDOM from 'react-dom';
import Dashboard from './Dashboard';
import { shallow, mount } from 'enzyme';

describe('Dashboard', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<Dashboard/>);
    
    expect(wrapper).toMatchSnapshot();
  });
  
  it('should render a <div>', () => {
    const wrapper = shallow(<Dashboard/>);

    expect(wrapper.find('div').length).toEqual(1);
  });
});


