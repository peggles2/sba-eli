import React from "react";
import LearningEvents from "../LearningEvents";
import { shallow } from "enzyme";

describe("LearningEvents", () => {
  it("should render a <div>", () => {
    const match = { params: { course_id: 1, module_id: 1, id: 1 } };
    const wrapper = shallow(<LearningEvents match={match} />);

    expect(wrapper.find("div").length).toEqual(1);
  });
});
