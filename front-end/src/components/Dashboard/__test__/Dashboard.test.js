import React from "react";
import Dashboard from "../Dashboard";
import LearningPaths from "../../LearningPath/LearningPaths";
import { shallow, mount } from "enzyme";

describe("Dashboard", () => {
  it("should render correctly", () => {
    const wrapper = shallow(<Dashboard />);

    expect(wrapper).toMatchSnapshot();
  });

  it("should render a <div>", () => {
    const wrapper = shallow(<Dashboard />);

    expect(wrapper.find("div").length).toEqual(1);
  });

  it("should render <LearningPaths>", () => {
    const wrapper = shallow(<Dashboard />);

    expect(wrapper.find(LearningPaths).length).toEqual(1);
  });
});
