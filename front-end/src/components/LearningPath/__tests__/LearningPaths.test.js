import React from "react";
import { LearningPaths } from "../LearningPaths";
import MetaTags from "../../SEO/MetaTags";
import { shallow } from "enzyme";
import { Helmet } from "react-helmet";

describe("LearningPaths", () => {
  it("should render meta tags with Learning Paths specific information", () => {
    const wrapper = shallow(<LearningPaths />);

    expect(wrapper.find(MetaTags).exists()).toBe(true);
    const metaWrapper = wrapper.find(MetaTags).dive();
    const helmetProps = metaWrapper.find(Helmet).props();

    expect(helmetProps.title).toBe("SBA Journeys");

    expect(helmetProps.meta[0].name).toBe("description");
    expect(helmetProps.meta[0].content).toBe(
      "Description for the Journey landing page"
    );

    //TODO: add Canonical URL validation when we have final urls
  });

  it("should render a <div>", () => {
    const wrapper = shallow(<LearningPaths />);

    expect(wrapper.find("div").length).toEqual(1);
  });
});
