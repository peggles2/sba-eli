import React from "react";
import LearningObjectives from "../LearningObjectives";
import { shallow } from "enzyme";

describe("LearningObjectives", () => {
  it("should render a <div>", () => {
    const match = { params: { course_id: "1" } };
    const wrapper = shallow(<LearningObjectives match={match} />);

    expect(wrapper.find("div").length).toEqual(1);
  });
});
