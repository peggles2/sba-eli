import React from "react";
import { shallow, mount } from "enzyme";
import { LearningPathBreadcrumb } from "../LearningPathBreadcrumb";
import { Breadcrumb } from "semantic-ui-react";

describe("LearningPathBreadcrumb", () => {
  it("should render a breadcrumb", () => {
    const wrapper = shallow(<LearningPathBreadcrumb/>);
    expect(wrapper.find(Breadcrumb).length).toBe(1);
  })

  it("should have a link to home", () => {
    const history = [];
    const wrapper = mount(<LearningPathBreadcrumb history={history} id={3} pathName={'foo'}/>);
    
    expect(wrapper.find(Breadcrumb).length).toBe(1);
    expect(wrapper.find(Breadcrumb.Section).length).toBe(2);

    wrapper.find(Breadcrumb.Section).first().simulate('click');
    expect(history.length).toBe(1);
    expect(history[0]).toBe('/');
  })

  it("should have a link to the learning path", () => {
    const history = [];
    const wrapper = mount(<LearningPathBreadcrumb history={history} id={3} pathName={'foo'}/>);
    
    expect(wrapper.find(Breadcrumb).length).toBe(1);
    expect(wrapper.find(Breadcrumb.Section).length).toBe(2);

    wrapper.find(Breadcrumb.Section).at(1).simulate('click');
    expect(history.length).toBe(1);
    expect(history[0]).toBe('/learning_paths/3');
  })  
});