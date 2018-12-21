import React from "react";
import { shallow, mount } from "enzyme";
import { Item } from "semantic-ui-react";
import TopicEventList from "../TopicEventList";
import { Link, MemoryRouter } from "react-router-dom";

describe("TopicProgressBar", () => {
  it("should render an Item.Group", () => {
    const props = { course_id: 1, module_id: 1 };

    const wrapper = shallow(<TopicEventList {...props} />);
    const eventsList = [{ id: 1, title: "Test" }];
    wrapper.setState({ eventsList });

    expect(wrapper.find(Item.Group).exists()).toBe(true);
  });

  it("should render a Link with the proper title", () => {
    const props = { course_id: 1, module_id: 1 };

    const wrapper = mount(
      <MemoryRouter>
        <TopicEventList {...props} />
      </MemoryRouter>
    );

    expect(
      wrapper
        .find(Link)
        .at(0)
        .text()
    ).toMatch(/Learning Event/);
  });

  //Expand to handle getting/mocking eventsList properly
});
