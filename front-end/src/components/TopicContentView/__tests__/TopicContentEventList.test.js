import React from "react";
import { shallow, mount } from "enzyme";
import TopicContentEventList from "../TopicContentEventList";
import { Grid } from "semantic-ui-react";
import { MemoryRouter } from "react-router-dom";

describe("TopicContentViewList", () => {
  it("should render correctly", () => {
    const wrapper = shallow(<TopicContentEventList />);

    expect(wrapper).toMatchSnapshot();
  });

  it("should render a <Grid>", () => {
    const props = {
      course_id: 1,
      module_id: 1
    };
    const wrapper = shallow(<TopicContentEventList {...props} />);

    expect(wrapper.find(Grid).exists()).toBe(false);
    //async call for eventsList won't fire in time for test, set state to render properly
    const eventsList = [{ id: 1, title: "Test Event" }];
    wrapper.setState({ eventsList });
    expect(wrapper.find(Grid).exists()).toBe(true);
  });
});
