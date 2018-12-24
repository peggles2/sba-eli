import React from "react";
import { shallow } from "enzyme";
import { Accordion, Item } from "semantic-ui-react";

import TopicContentItem from "../TopicContentItem";

describe("TopicProgressBar", () => {
  it("should render all base parts of TopicContentItem", () => {
    const topic = { id: 1, name: "Test" };
    const props = { course_id: 1, topic };

    const wrapper = shallow(<TopicContentItem {...props} />);

    expect(wrapper.find(Item.Group).exists()).toBe(true);
    expect(wrapper.find(Accordion).exists()).toBe(true);
  });

  it("should render the topic name properly", () => {
    const topic = { id: 1, name: "Test" };
    const props = { course_id: 1, topic };

    const wrapper = shallow(<TopicContentItem {...props} />);

    expect(
      wrapper
        .find(Item.Header)
        .dive()
        .text()
    ).toMatch(topic.name);
    expect(wrapper.find(Accordion).exists()).toBe(true);
  });

  it("should handle the click on event list expander properly", () => {
    const topic = { id: 1, name: "Test" };
    const props = { course_id: 1, topic };

    const wrapper = shallow(<TopicContentItem {...props} />);

    expect(wrapper.state("listVisible")).toBe(true);
    wrapper.find(".topic-content-collapse-button").simulate("click");
    expect(wrapper.state("listVisible")).toBe(false);
  });
});
