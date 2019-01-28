import React from "react";
import { shallow } from "enzyme";
import LearningObjectives from "../LearningObjectives";
import LearningObjectivesList from "../LearningObjectivesList";
import { Helmet } from "react-helmet";
import MetaTags from "../../SEO/MetaTags";

describe("LearningObjectives", () => {
  it("should render meta tags with Learning Objectives specific information", () => {
    const match = { params: { course_id: 1 } };
    const wrapper = shallow(<LearningObjectives match={match} />);

    expect(wrapper.find(MetaTags).exists()).toBe(true);
    const metaWrapper = wrapper.find(MetaTags).dive();
    const helmetProps = metaWrapper.find(Helmet).props();

    expect(helmetProps.title).toBe("SBA Learning Objectives");
    expect(helmetProps.meta[0].name).toBe("description");
    expect(helmetProps.meta[0].content).toBe(
      "Description for the Learning Objectives landing page"
    );

    //TODO: add Canonical URL validation when we have final urls
  });

  it("should render a <LearningObjectivesList>", () => {
    const match = { params: { course_id: 1 } };
    const wrapper = shallow(<LearningObjectives match={match} />);

    expect(wrapper.find(LearningObjectivesList).exists()).toBe(true);
  });
});
