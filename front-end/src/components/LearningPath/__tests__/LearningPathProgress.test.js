import React  from "react";
import LearningPathProgress from "../LearningPathProgress";
import { Grid, Progress } from "semantic-ui-react";
import { shallow } from "enzyme";

describe("LearningPathProgress", () => {

  it("renders a progress bar", () => {
    const wrapper = shallow(<LearningPathProgress complete={3} total={5} />);

    expect(wrapper.find(Progress).exists()).toBe(true);
  });

  describe("progressPercent", () => {
    test("gives a percentage of completed progress", () => {
      const complete = 3;
      const total = 5;
      const wrapper = shallow(<LearningPathProgress complete={complete} total={total} />);
      const inst = wrapper.instance()

      const progressPercent = inst.progressPercent(complete, total);

      expect(progressPercent).toEqual(60);
    });
  });
});
