import React from "react";
import LearningEvents from "../LearningEvents";
import LearningEventsList from "../LearningEventsList";
import MetaTags from "../../SEO/MetaTags";
import { Helmet } from "react-helmet";
import { shallow } from "enzyme";

describe("LearningEvents", () => {
  it("should render a <LearningEventsList>", () => {
    const match = { params: { course_id: 1, module_id: 1, id: 1 } };
    const wrapper = shallow(<LearningEvents match={match} />);

    expect(wrapper.find(LearningEventsList).length).toEqual(1);
  });

  it("should render meta tags with Learning Events specific information", () => {
    const match = { params: { course_id: 1, module_id: 2, id: 3 } };
    const wrapper = shallow(<LearningEvents match={match} />);

    expect(wrapper.find(MetaTags).exists()).toBe(true);

    const metaWrapper = wrapper.find(MetaTags).dive();
    const helmetProps = metaWrapper.find(Helmet).props();

    expect(helmetProps.title).toBe("Learning Events");
    expect(helmetProps.meta[0].name).toBe("description");
    expect(helmetProps.meta[0].content).toBe(
      "Description for the Learning Events landing page"
    );
    expect(helmetProps.link[0].rel).toBe("canonical");
    expect(helmetProps.link[0].href).toBe(
      "https://sba.gov/learning_paths/1/learning_objectives/2/learning_events"
    );
  });
});
