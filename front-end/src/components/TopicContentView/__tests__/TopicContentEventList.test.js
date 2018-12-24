import React from "react";
import { shallow, mount } from "enzyme";
import TopicContentEventList from "../TopicContentEventList";
import { Item } from "semantic-ui-react";

describe("TopicContentViewList", () => {
  it("should render correctly", () => {
    const wrapper = shallow(<TopicContentEventList />);

    expect(wrapper).toMatchSnapshot();
  });

  it("should render a <Navbar>", () => {
    const wrapper = shallow(<TopicContentEventList />);

    expect(wrapper.find(Item.Group).exists()).toBe(true);
  });
});
