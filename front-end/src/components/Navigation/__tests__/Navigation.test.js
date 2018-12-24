import React from "react";
import Navigation from "../Navigation";
import Navbar from "../Navbar";
import { shallow } from "enzyme";

describe("Navigation", () => {
  it("should render correctly", () => {
    const wrapper = shallow(<Navigation />);

    expect(wrapper).toMatchSnapshot();
  });

  it("should render a <div>", () => {
    const wrapper = shallow(<Navigation />);

    expect(wrapper.find("div").length).toEqual(2);
  });

  it('should render a <Navbar>', () => {
    const wrapper = shallow(<Navigation/>);

    expect(wrapper.find(Navbar).exists()).toBe(true);
  });
});
