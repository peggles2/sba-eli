import React from "react";
import { Form, List } from "semantic-ui-react";
import ConnectedSignUpForm, { SignUpForm } from "../SignUpForm";
import { shallow, mount } from "enzyme";

describe("SignUpForm", () => {
  it("should render a <Form>", () => {
    const wrapper = shallow(<ConnectedSignUpForm.WrappedComponent />);

    expect(wrapper.find(Form).length).toEqual(1);
  });

  it("should render 8 fields", () => {
    const wrapper = shallow(<ConnectedSignUpForm.WrappedComponent />);

    expect(wrapper.find(Form.Field).length).toEqual(8);
  });

  it("can render errors on an update", () => {
    const wrapper = shallow(<ConnectedSignUpForm.WrappedComponent/>);
    expect(wrapper.find('Message').length).toEqual(0);
    
    wrapper.setProps({errors:{first_name:['error']}})
    expect(wrapper.find('Message').length).toEqual(1);
  });

  it("can submit the form", () => {
    const dispatch = jasmine.createSpy();
    const wrapper = shallow(<ConnectedSignUpForm.WrappedComponent dispatch={dispatch}/>);
    expect(wrapper.find('Button').length).toEqual(1);
    wrapper.find('Form').simulate('submit', {preventDefault: function(){}});
    expect(dispatch).toHaveBeenCalled();
  })
});