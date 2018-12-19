import React from "react";
import { Header } from "semantic-ui-react";
import LearningPath from "../LearningPath";
import LearningEvent from "../../LearningEvent/LearningEvent";
import MetaTags from "../../SEO/MetaTags";
import TopicContentView from "../../TopicContentView/TopicContentView";
import { shallow } from "enzyme";

describe("LearningPath", () => {
  it("should render meta tags with Learning Path specific information", () => {
    const match = { params: { id: 1 } };
    const wrapper = shallow(<LearningPath match={match} />);
    const name = "Learning Path Name"
    const desc = "Learning Path Description"
    const learningPath = {name: name, description: desc} 
    wrapper.instance().setState({learningPath});

    expect(wrapper.find(MetaTags).exists()).toBe(true);
    const metaWrapper = wrapper.find(MetaTags).dive();

    expect(metaWrapper.find('title').text()).toBe(name);
    expect(metaWrapper.find("meta[name='author']").exists()).toBe(false);
    expect(metaWrapper.find("meta[name='description']").exists()).toBe(true);
    expect(metaWrapper.find("meta[name='description']").props().content).toBe(desc);
    //TODO: add Canonical URL validation when we have final urls
  });

  it("should render all parts for base landing page", () => {
    const match = { params: { id: 1 } };
    const wrapper = shallow(<LearningPath match={match} />);

    expect(wrapper.find("div").length).toEqual(1);
    expect(wrapper.find(Header).exists()).toBe(true);
    expect(wrapper.find(TopicContentView).exists()).toBe(true);
  });

  it("should render all parts for navigating into a learning event", () => {
    const match = { params: { id: 1, eventId: 1, topicId: 1 } };

    const wrapper = shallow(<LearningPath match={match} />);

    expect(wrapper.find("div").length).toEqual(1);
    expect(wrapper.find(Header).exists()).toBe(true);
    expect(wrapper.find(LearningEvent).exists()).toBe(true);
  });
});
