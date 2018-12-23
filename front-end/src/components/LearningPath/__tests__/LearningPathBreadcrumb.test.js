import React from "react";
import { Breadcrumb } from "semantic-ui-react";
import LearningPathBreadcrumb from "../LearningPathBreadcrumb";
import { shallow } from "enzyme";

describe("LearningPathBreadcrumb", () => {
  it("should render correctly", () => {
    const item = { id: 1, pathName: "LP 1" };
    const wrapper = shallow(<LearningPathBreadcrumb {...item} />);

    expect(wrapper).toMatchSnapshot();
  });

  it("should render a <Breadcrumb>", () => {
    const item = { id: 1, pathName: "LP 1" };
    const wrapper = shallow(<LearningPathBreadcrumb {...item} />);

    expect(wrapper.find(Breadcrumb).exists()).toBe(true);
    expect(wrapper.find(Breadcrumb.Section).exists()).toBe(true);
  });
});
