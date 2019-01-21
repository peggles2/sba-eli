import React from "react";
import { shallow, mount } from "enzyme";
import { TopicContentEventList } from "../TopicContentEventList";
import { Grid } from "semantic-ui-react";
import { MemoryRouter } from "react-router-dom";

describe("TopicContentViewList", () => {
  it("should render a <Grid>", () => {
    let props = {
      course_id: 1,
      module_id: 1,
      learningEvents: [],
      dispatch: ()=>{}
    };
    let wrapper = shallow(<TopicContentEventList {...props} />);
    expect(wrapper.find(Grid).exists()).toBe(false);
    
    props = {
      course_id: 1,
      module_id: 1,
      learningEvents: [{ id: 1, title: "Test Event" }],
      dispatch: ()=>{}
    };
    wrapper = shallow(<TopicContentEventList {...props} />);
    expect(wrapper.find(Grid).exists()).toBe(true);
  });
});
