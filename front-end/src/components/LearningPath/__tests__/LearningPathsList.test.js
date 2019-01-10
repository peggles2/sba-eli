import React from 'react';
import { Card } from 'semantic-ui-react';
import ConnectedLearningPathsList, { LearningPathsList } from '../LearningPathsList';
import { shallow, mount } from 'enzyme';

describe('LearningPathsList', () => {
  const lps = [
    { id: 1, name: "Course 1" },
    { id: 2, name: "Course 2" },
    { id: 3, name: "Course 3" },
    { id: 4, name: "Course 4" },
  ]
  
  it('should render correctly', () => {
    const wrapper = shallow(<LearningPathsList learningPaths={lps} dispatch={() => {}}/>);

    expect(wrapper).toMatchSnapshot();
  });
  
  it('should render a <div>', () => {
    const wrapper = shallow(<LearningPathsList learningPaths={lps} dispatch={() => {}}/>);

    expect(wrapper.find('div').length).toEqual(1);
  });

  describe('rendering the list', () => {
    /*
    
    var wrapper = mount(<LearningPathsList learningPaths={lps} />)

    it('should render a <Card.Group>', () => {
      expect(wrapper.find(Card.Group).length).toEqual(1);
    });
    
    it('should render a 4 <Card>s', () => {
      expect(wrapper.find(Card).length).toEqual(4);
    });
    */
  })
});
