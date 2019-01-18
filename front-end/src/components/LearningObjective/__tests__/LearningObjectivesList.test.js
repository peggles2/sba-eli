import React from "react";
import { List } from "semantic-ui-react";
import LearningObjectivesList from "../LearningObjectivesList";
import { shallow, mount } from "enzyme";

describe("LearningObjectivesList", () => {
  it("should render a <List>", () => {
    const wrapper = shallow(<LearningObjectivesList />);

    expect(wrapper.find(List).length).toEqual(1);
  });

  it("should render at least one <li>", () => {
    const wrapper = mount(<LearningObjectivesList course_id="1" />);

    expect(wrapper.find(List).length).toBeGreaterThanOrEqual(1);
  });
});
