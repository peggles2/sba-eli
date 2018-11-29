import React from "react";
import { form, List } from "semantic-ui-react";
import SignUpForm from "../SignUpForm";
import { shallow, mount } from "enzyme";

describe("SignUpForm", () => {
  it("should render correctly", () => {
    const wrapper = shallow(<SignUpForm />);

    expect(wrapper).toMatchSnapshot();
  });

  it("should render a <form>", () => {
    const wrapper = shallow(<SignUpForm />);

    expect(wrapper.find("Form").length).toEqual(1);
  });
})