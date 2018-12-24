import React from "react";
import LearningEvent from "../LearningEvent";
import { shallow, mount } from "enzyme";

describe("LearningEvent", () => {
  it("should render correctly", () => {
    const match = { params: { course_id: 1, module_id: 1, id: 1 } };
    const wrapper = shallow(<LearningEvent match={match} />);

    expect(wrapper).toMatchSnapshot();
  });

  it("should render a <div>", () => {
    const match = { params: { course_id: 1, module_id: 1, id: 1 } };
    const wrapper = mount(<LearningEvent match={match} />);

    expect(wrapper.find("div").length).toBeGreaterThanOrEqual(1);
  });
});
