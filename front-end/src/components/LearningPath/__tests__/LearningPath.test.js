import React from "react";
import { Header, Grid } from "semantic-ui-react";
import { LearningPath } from "../LearningPath";
import LearningEvent from "../../LearningEvent/LearningEvent";
import MetaTags from "../../SEO/MetaTags";
import TopicContentView from "../../TopicContentView/TopicContentView";
import { shallow } from "enzyme";

function pathWrapper(eventId = null, topicId = null) {
  const match = { params: { id: 1, eventId, topicId } };

  const name = "Learning Path Name";
  const desc = "Learning Path Description";
  const learningPath = { name: name, description: desc };
  const props = {
    learningPath,
    match,
    topicsList: [],
    dispatch: () => {}
  };

  const wrapper = shallow(<LearningPath {...props} />);

  return { name, desc, wrapper };
}

describe("LearningPath", () => {
  it("should render meta tags with Learning Path specific information", () => {
    const { name, desc, wrapper } = pathWrapper();

    expect(wrapper.find(MetaTags).exists()).toBe(true);
    const metaWrapper = wrapper.find(MetaTags).dive();

    expect(metaWrapper.find("title").text()).toBe(name);
    expect(metaWrapper.find("meta[name='author']").exists()).toBe(false);
    expect(metaWrapper.find("meta[name='description']").exists()).toBe(true);
    expect(metaWrapper.find("meta[name='description']").props().content).toBe(
      desc
    );
    //TODO: add Canonical URL validation when we have final urls
  });

  it("should render all parts for base landing page", () => {
    const { wrapper } = pathWrapper();

    expect(wrapper.find(Grid).exists()).toBe(true);
    expect(wrapper.find(Header).exists()).toBe(true);
    expect(wrapper.find(TopicContentView).exists()).toBe(true);
  });

  it("should render all parts for navigating into a learning event", () => {
    const eventId = 1;
    const topicId = 1;
    const { wrapper } = pathWrapper(eventId, topicId);

    expect(wrapper.find(Grid).exists()).toBe(true);
    expect(wrapper.find(Header).exists()).toBe(true);
    expect(wrapper.find(LearningEvent).exists()).toBe(true);
  });
});
