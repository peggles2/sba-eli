import React from "react";
import LearningObjective from "../LearningObjective";
import LearningEventsList from "../../LearningEvent/LearningEventsList";
import MetaTags from "../../SEO/MetaTags";
import { shallow, mount } from "enzyme";

describe("LearningObjective", () => {
  it("should render meta tags with Learning Objective specific information", () => {
    const match = { params: { id: 1 } };
    const title = "Learning Objective!"
    const desc = "learning objective description text"
    const learningObjective = { name: title, description: desc};
    
    const wrapper = shallow(<LearningObjective match={match} />);
    wrapper.instance().setState({learningObjective});

    expect(wrapper.find(MetaTags).exists()).toBe(true);
    const metaWrapper = wrapper.find(MetaTags).dive();

    expect(metaWrapper.find('title').text()).toBe(title);
    expect(metaWrapper.find("meta[name='author']").exists()).toBe(false);
    expect(metaWrapper.find("meta[name='description']").exists()).toBe(true);
    expect(metaWrapper.find("meta[name='description']").props().content).toBe(desc);
    //TODO: add Canonical URL validation when we have final urls
  });

  it("should render a single h1 and it should display the objective title", () => {
    const match = { params: { id: 1 } };
    const title = "Learning Objective!"
    const desc = "learning objective description text"
    const learningObjective = { name: title, description: desc};
    
    const wrapper = mount(<LearningObjective match={match} />);
    wrapper.instance().setState({learningObjective});

    expect(wrapper.find("h1").exists()).toBe(true);
    expect(wrapper.find("h1").length).toEqual(1);
    expect(wrapper.find("h1").text()).toEqual(title);
  });

  it("should render a <LearningEventsList>", () => {
    const match = { params: { id: 1 } };
    const wrapper = mount(<LearningObjective match={match} />);

    expect(wrapper.find(LearningEventsList).exists()).toBe(true);
  });
});
