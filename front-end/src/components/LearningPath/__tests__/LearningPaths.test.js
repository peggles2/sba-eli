import React from 'react';
import { LearningPaths } from '../LearningPaths';
import MetaTags from '../../SEO/MetaTags';
import { shallow, mount } from 'enzyme';

describe('LearningPaths', () => {
  it("should render meta tags with Learning Paths specific information", () => {
    const wrapper = shallow(<LearningPaths />);

    expect(wrapper.find(MetaTags).exists()).toBe(true);
    const metaWrapper = wrapper.find(MetaTags).dive();

    expect(metaWrapper.find('title').text()).toBe("SBA Learning Paths");
    expect(metaWrapper.find("meta[name='author']").exists()).toBe(false);
    expect(metaWrapper.find("meta[name='description']").exists()).toBe(true);
    expect(metaWrapper.find("meta[name='description']").props().content).toBe("Description for the Learning Path landing page");
    //TODO: add Canonical URL validation when we have final urls
  });

  it('should render a <div>', () => {
    const wrapper = shallow(<LearningPaths />);

    expect(wrapper.find('div').length).toEqual(1);
  });
});
