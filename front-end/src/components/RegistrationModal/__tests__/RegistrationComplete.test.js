import React from "react";
import RegistrationComplete from "../RegistrationComplete";
import { shallow } from "enzyme";

describe("RegistrationComplete", () => {
  it("renders a grid", () => {
    const wrapper = shallow(<RegistrationComplete />);

    expect(wrapper.find("Grid").exists()).toBe(true);
  });
});