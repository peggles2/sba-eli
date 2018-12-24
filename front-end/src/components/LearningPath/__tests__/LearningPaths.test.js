import React from 'react';
import { LearningPaths } from '../LearningPaths';
import { shallow, mount } from 'enzyme';

describe('LearningPaths', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<LearningPaths />);

    expect(wrapper).toMatchSnapshot();
  });

  it('should render a <div>', () => {
    const wrapper = shallow(<LearningPaths />);

    expect(wrapper.find('div').length).toEqual(1);
  });
});
