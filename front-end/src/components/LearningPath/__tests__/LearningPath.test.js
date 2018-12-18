import React from "react";
import { Header, Grid } from "semantic-ui-react";
import LearningPath from "../LearningPath";
import LearningEvent from "../../LearningEvent/LearningEvent";
import { shallow } from "enzyme";
import TopicContentView from "../../TopicContentView/TopicContentView";

describe("LearningPath", () => {
  it("should render correctly", () => {
    const match = { params: { id: 1 } };
    const wrapper = shallow(<LearningPath match={match} />);

    expect(wrapper).toMatchSnapshot();
  });

  it("should render all parts for base landing page", () => {
    const match = { params: { id: 1 } };
    const wrapper = shallow(<LearningPath match={match} />);

    expect(wrapper.find(Grid).exists()).toBe(true);
    expect(wrapper.find(Header).exists()).toBe(true);
    expect(wrapper.find(TopicContentView).exists()).toBe(true);
  });

  it("should render all parts for navigating into a learning event", () => {
    const match = { params: { id: 1, eventId: 1, topicId: 1 } };

    const wrapper = shallow(<LearningPath match={match} />);

    expect(wrapper.find(Grid).exists()).toBe(true);
    expect(wrapper.find(Header).exists()).toBe(true);
    expect(wrapper.find(LearningEvent).exists()).toBe(true);
  });
});
