import React from "react";
import { TopicProgress } from "../TopicProgress";
import RegisterButton  from "../../Buttons/RegisterButton";
import { shallow } from "enzyme";
import { Grid, Button, Progress } from "semantic-ui-react";

describe("TopicProgressBar", () => {
  it("should render a Grid", () => {
    const wrapper = shallow(<TopicProgress />);

    expect(wrapper.find(Grid).exists()).toBe(true);
  });

  it("should show a register button and appropriate text if logged out", () => {
    const props = { isUserLoggedIn: false }
    const wrapper = shallow(<TopicProgress {...props}/>);

    expect(wrapper.find(Grid).exists()).toBe(true);
    expect(wrapper.find(RegisterButton).exists()).toBe(true)
    expect(
      wrapper
        .find(Grid.Column)
        .at(0)
        .dive()
        .text()
    ).toMatch(/Track your journey!/);
  });

  it("should show a progress bar if logged in and not all topics complete", () => {
    const props = {
      isUserLoggedIn: true,
      topicsTotal: 10,
      learningPathProgress: {
        course_progress: {
          requirement_completed_count: 2,
          requirement_count: 10,
        },
      },
      getProgressOfLearningPath: jest.fn()
    };

    const wrapper = shallow(<TopicProgress {...props} />);

    expect(wrapper.find(Grid).exists()).toBe(true);
    expect(wrapper.find(Progress).exists()).toBe(true);
  });

  it("should show a appropriate text if logged in and all topics complete", () => {
    const props = {
      isUserLoggedIn: true,
      topicsTotal: 10,
      learningPathProgress: {
        course_progress: {
          requirement_completed_count: 10,
          requirement_count: 10,
        },
      },
      getProgressOfLearningPath: jest.fn()
    };

    const wrapper = shallow(<TopicProgress {...props} />);

    expect(wrapper.find(Grid).exists()).toBe(true);

    expect(
      wrapper
        .find(Grid.Column)
        .dive()
        .text()
    ).toMatch(/You've finished your journey!/);
  });
});
