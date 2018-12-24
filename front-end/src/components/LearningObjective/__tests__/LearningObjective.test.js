import React from "react";
import LearningObjective from "../LearningObjective";
import { shallow, mount } from "enzyme";

describe("LearningObjective", () => {
  it("should render correctly", () => {
    const match = { params: { id: 1 } };
    const wrapper = shallow(<LearningObjective match={match} />);

    expect(wrapper).toMatchSnapshot();
  });

  it("should render a <div>", () => {
    const match = { params: { id: 1 } };
    const wrapper = shallow(<LearningObjective match={match} />);

    expect(wrapper.find("div").length).toEqual(1);
  });
});
