import React from "react";
import { shallow, mount } from "enzyme";
import TopicContentView from "../TopicContentView";
import { Item } from "semantic-ui-react";

describe("TopicContentView", () => {
  it("should render a <Item.Group>", () => {
    const topicsList = [{ name: "Test", id: 1 }];
    const wrapper = mount(
      <TopicContentView course_id={1} topicsList={topicsList} />
    );

    expect(wrapper.find(Item.Group).exists()).toBe(true);
  });
});
