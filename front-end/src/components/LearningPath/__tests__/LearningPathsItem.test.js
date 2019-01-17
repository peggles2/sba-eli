import React from "react";

import { shallow, mount } from "enzyme";
import { LearningPathsItem } from '../LearningPathsItem'

describe("LearningPathsItem", () => {
  it("should render a Card", () => {
    const wrapper = shallow(<LearningPathsItem/>);
    expect(wrapper.find("Card").length).toBe(1);
  });

  it("has a placeholder", () => {
    const wrapper = shallow(<LearningPathsItem/>);
    expect(wrapper.find("Image").length).toBe(1);
  });

  it("should have a link to the learning path", () => {
    const history = [];
    const wrapper = mount(<LearningPathsItem history={history} id={1}/>);
    
    wrapper.find('a').first().simulate('click');
    expect(history.length).toBe(1);
    expect(history[0]).toBe('/learning_paths/1');
  })  
});