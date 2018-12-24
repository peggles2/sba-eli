import React from "react";
import Navbar from "../Navbar";
import Navigation from "../Navigation";
import NavigationDisplay from "../NavigationDisplay";
import { shallow } from "enzyme";

describe("Navigation", () => {

  it('should render a <Navbar>', () => {
    const wrapper = shallow(<Navigation/>);

    expect(wrapper.find(Navbar).exists()).toBe(true);
  });

  it('should render a <NavigationDisplay>', () => {
    const wrapper = shallow(<Navigation/>);

    expect(wrapper.find(NavigationDisplay).exists()).toBe(true);
  });
});
