import React from 'react';
import {Form} from 'semantic-ui-react';
import ConnectedLoginForm, { LoginForm } from "../LoginForm";
import { shallow, mount } from "enzyme";

describe("LoginForm", () => {
  it("should render a Form", () => {
    const wrapper = shallow(<ConnectedLoginForm.WrappedComponent />);

    expect(wrapper.find(Form).length).toEqual(1);
  });

  it("should render 8 fields", () => {
    const wrapper = shallow(<ConnectedLoginForm.WrappedComponent />);

    expect(wrapper.find(Form.Field).length).toEqual(2);
  });

  it("can render errors on an update", () => {
    const wrapper = shallow(<ConnectedLoginForm.WrappedComponent userError={'bad'}/>);
    expect(wrapper.find('Message').length).toEqual(1);
  });

  it("can submit the form", () => {
    const dispatch = jasmine.createSpy();
    const wrapper = shallow(<ConnectedLoginForm.WrappedComponent dispatch={dispatch}/>);
    expect(wrapper.find('Button').length).toEqual(1);
    wrapper.find('Form').simulate('submit', {preventDefault: function(){}});
    expect(dispatch).toHaveBeenCalled();
  })
});