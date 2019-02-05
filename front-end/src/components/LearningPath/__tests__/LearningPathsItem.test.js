import React from "react";

import { shallow, mount } from "enzyme";
import { LearningPathsItem } from '../LearningPathsItem'

describe("LearningPathsItem", () => {
  it("should render a Card", () => {
    const wrapper = shallow(<LearningPathsItem learningPaths={[]}/>);
    expect(wrapper.find("Card").length).toBe(1);
  });

  it("has a placeholder", () => {
    const wrapper = shallow(<LearningPathsItem learningPaths={[]}/>);
    expect(wrapper.find("Image").length).toBe(1);
  });

  it("should have a link to the learning path", () => {
    const history = [];
    const wrapper = mount(<LearningPathsItem learningPaths={[]} history={history} id={1}/>);
    
    let href = wrapper.find('a').first().getDOMNode().getAttribute('href');
    expect(href).toBe('/learning_paths/1');
  })  
});