import React from "react";
import { shallow } from "enzyme";
import { Container, Accordion } from "semantic-ui-react";
import TopicSideBar from "../TopicSidebar";
import TopicProgress from "../TopicProgress";
import TopicEventList from "../TopicEventList";

describe("TopicProgressBar", () => {
  it("should render all base parts of Sidebar", () => {
    const topicsList = [{ id: 1, name: "Test" }];
    const props = { course_id: 1, topicsList: topicsList };

    const wrapper = shallow(<TopicSideBar {...props} />);

    expect(wrapper.find(Container).exists()).toBe(true);
    expect(wrapper.find(Accordion).exists()).toBe(true);
    expect(wrapper.find(TopicEventList).exists()).toBe(true);
    expect(wrapper.find(TopicProgress).exists()).toBe(true);
  });

  it("should not render all base parts of Sidebar if no topics", () => {
    const topicsList = [];
    const props = { course_id: 1, topicsList: topicsList };

    const wrapper = shallow(<TopicSideBar {...props} />);

    expect(wrapper.find(Container).exists()).toBe(false);
    expect(wrapper.find(Accordion).exists()).toBe(false);
    expect(wrapper.find(TopicEventList).exists()).toBe(false);
    expect(wrapper.find(TopicProgress).exists()).toBe(false);
  });

  it("should show appropriate topic name ", () => {
    const topicsList = [{ id: 1, name: "Test" }];
    const props = { course_id: 1, topicsList: topicsList };

    const wrapper = shallow(<TopicSideBar {...props} />);

    expect(
      wrapper
        .find(Accordion.Title)
        .dive()
        .text()
    ).toMatch(/Test/);
  });

  it("should show appropriate number of topics", () => {
    const topicsList = [{ id: 1, name: "Test" }, { id: 2, name: "Test2" }];
    const props = { course_id: 1, topicsList: topicsList };

    const wrapper = shallow(<TopicSideBar {...props} />);

    expect(wrapper.find(Accordion.Title).length).toEqual(topicsList.length);
  });
});
