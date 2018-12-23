import React from "react";
import { List } from "semantic-ui-react";
import LearningEventsItem from "../LearningEventsItem";
import { shallow } from "enzyme";

describe("LearningEventsItem", () => {
  it("should render correctly", () => {
    const item = { id: 1, title: "LE 1" };
    const wrapper = shallow(<LearningEventsItem item={item} />);

    expect(wrapper).toMatchSnapshot();
  });

  it("should render a <List>", () => {
    const item = { id: 1, title: "LE 1" };
    const wrapper = shallow(<LearningEventsItem item={item} />);

    expect(wrapper.find(List.Item).length).toEqual(1);
  });
});
