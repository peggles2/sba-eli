import React from "react";
import { RegisterButton } from "../RegisterButton";
import { Button } from "semantic-ui-react";

import { shallow } from "enzyme";

describe("RegisterButton", () => {
  it("renders a Button", () => {
    const wrapper = shallow( <RegisterButton /> );

    expect(wrapper.find(Button).exists()).toBe(true);
  });
});
