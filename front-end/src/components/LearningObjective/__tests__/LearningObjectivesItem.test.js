import React from "react";
import { List } from "semantic-ui-react";
import LearningObjectivesItem from "../LearningObjectivesItem";
import { shallow } from "enzyme";

describe("LearningObjectivesItem", () => {
  it("should render a <List.Item>", () => {
    const item = { id: 1, name: "LO 1" };
    const wrapper = shallow(<LearningObjectivesItem item={item} />);

    expect(wrapper.find(List.Item).length).toEqual(1);
  });
});
