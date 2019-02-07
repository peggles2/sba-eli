import React from "react";
import { LearningPathResume } from "../LearningPathResume";
import { Container, Header } from "semantic-ui-react";
import { shallow } from "enzyme";


describe("LearningPathResume", () => {
  it("should render a container", () => {
    const props = {
      learningPathProgress: {
        name: "Leadership",
      },
      getProgressOfLearningPath: jest.fn()
    }

    const wrapper = shallow(
        <LearningPathResume {...props} />
    );

    expect(wrapper.find(Container).exists()).toBe(true);
  });
});
