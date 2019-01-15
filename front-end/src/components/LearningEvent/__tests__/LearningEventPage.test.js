import React from "react";
import { LearningEventPage } from "../LearningEventPage";
import { shallow } from "enzyme";

describe("LearningEventPage", () => {
  it("should render correctly", () => {
    const event = { eventContent: { body: "<div></div>" } };
    const wrapper = shallow(<LearningEventPage event={event} />);

    expect(wrapper.find("div").exists()).toBe(true);
  });
});
