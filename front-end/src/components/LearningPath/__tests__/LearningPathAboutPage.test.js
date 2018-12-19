import React from 'react';
import { Button, Header } from 'semantic-ui-react';
import LearningPathAboutPage from '../LearningPathAboutPage';
import { shallow } from 'enzyme';

describe('LearningPathAbout', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<LearningPathAboutPage />);
    
    expect(wrapper).toMatchSnapshot();
  });
  
  it('should render page 1', () => {
    const wrapper = shallow(<LearningPathAboutPage page={1} />);
    
    expect(wrapper.find(Header).children().text()).toEqual("Welcome");
    expect(wrapper.find(Button).length).toEqual(1);
    expect(wrapper.find(Button).children().text()).toEqual("Next");
  });
  
  it('should render page 2', () => {
    const wrapper = shallow(<LearningPathAboutPage page={2} />);
    
    expect(wrapper.find(Header).children().text()).toEqual("About")
    expect(wrapper.find(Button).length).toEqual(1);
    expect(wrapper.find(Button).children().text()).toEqual("Next");
  });
  
  it('should render page 3', () => {
    const wrapper = shallow(<LearningPathAboutPage page={3} />);
    
    expect(wrapper.find(Header).children().text()).toEqual("Save Your Progress")
    expect(wrapper.find(Button).length).toEqual(2);
    expect(wrapper.find(Button).children().at(0).text()).toEqual("Register");
    expect(wrapper.find(Button).children().at(1).text()).toEqual("Skip For Now");
  });
  
  it('should render page 4', () => {
    const wrapper = shallow(<LearningPathAboutPage page={4} />);
    
    expect(wrapper.find(Header).children().text()).toEqual("Start Your Path")
    expect(wrapper.find(Button).length).toEqual(1);
    expect(wrapper.find(Button).children().at(0).text()).toEqual("Start First Learning Path");
  });
});