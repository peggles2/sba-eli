import React from "react";
import { shallow, mount } from "enzyme";
import { TopicContentEventList } from "../TopicContentEventList";
import { Grid } from "semantic-ui-react";

describe("TopicContentViewList", () => {
  it("should render a <Grid>", () => {
    let props = {
      course_id: 1,
      module_id: 1,
      learningEventsCollection: {},
      dispatch: () => {}
    };
    let wrapper = shallow(<TopicContentEventList {...props} />);
    expect(wrapper.find(Grid).exists()).toBe(false);

    props = {
      course_id: 1,
      module_id: 1,
      learningEventsCollection: { 1: { 1: [{ title: "Test Event" }] } },
      dispatch: () => {}
    };
    wrapper = shallow(<TopicContentEventList {...props} />);
    expect(wrapper.find(Grid).exists()).toBe(true);
  });
});
