import React from "react";
import LearningEventFile from "../LearningEventFile";
import { shallow } from "enzyme";

describe("LearningEventFile", () => {
  it("should render correctly", () => {
    const event = { url: "http://example.me" }
    const wrapper = shallow(<LearningEventFile event={event}/>);

    expect(wrapper).toMatchSnapshot();
  });
});
