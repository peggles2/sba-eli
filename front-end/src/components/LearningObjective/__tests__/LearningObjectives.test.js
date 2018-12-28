import React from "react";
import { shallow } from "enzyme";
import LearningObjectives from "../LearningObjectives";
import LearningObjectivesList from "../LearningObjectivesList";
import MetaTags from "../../SEO/MetaTags";

describe("LearningObjectives", () => {
  it("should render meta tags with Learning Objectives specific information", () => {
    const match = { params: { course_id: 1 } };
    const wrapper = shallow(<LearningObjectives match={match} />);

    expect(wrapper.find(MetaTags).exists()).toBe(true);
    const metaWrapper = wrapper.find(MetaTags).dive();

    expect(metaWrapper.find('title').text()).toBe("SBA Learning Objectives");
    expect(metaWrapper.find("meta[name='author']").exists()).toBe(false);
    expect(metaWrapper.find("meta[name='description']").exists()).toBe(true);
    expect(metaWrapper.find("meta[name='description']").props().content).toBe("Description for the Learning Objectives landing page");
    //TODO: add Canonical URL validation when we have final urls
  });

  it("should render a <LearningObjectivesList>", () => {
    const match = { params: { course_id: 1 } };
    const wrapper = shallow(<LearningObjectives match={match} />);

    expect(wrapper.find(LearningObjectivesList).exists()).toBe(true);
  });
});
