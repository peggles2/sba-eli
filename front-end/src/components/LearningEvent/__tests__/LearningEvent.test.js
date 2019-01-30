import React from "react";

import { LearningEvent } from "../LearningEvent";
import LearningEventManager from "../LearningEventManager";
import MetaTags from "../../SEO/MetaTags";
import { shallow } from "enzyme";
import LearningEventHeader from "../LearningEventHeader";
import { Helmet } from "react-helmet";
import LearningEventFooter from "../LearningEventFooter";

function eventWrapper() {
  const match = { params: { course_id: 1, module_id: 1, id: 1 } };
  const title = "learning event title";
  const desc = "learning event description";
  const learningEvent = { title: title, description: desc };
  const props = {
    learningEvent,
    match,
    learningEventsCollection: {},

    dispatch: () => {}
  };

  const wrapper = shallow(<LearningEvent {...props} />);

  return { title, desc, wrapper };
}

describe("LearningEvent", () => {
  it("should render meta tags with Learning Event specific information", () => {
    const { title, desc, wrapper } = eventWrapper();

    expect(wrapper.find(MetaTags).exists()).toBe(true);
    const metaWrapper = wrapper.find(MetaTags).dive();
    const helmetProps = metaWrapper.find(Helmet).props();

    expect(helmetProps.title).toBe(title);
    expect(helmetProps.meta[0].name).toBe("description");
    expect(helmetProps.meta[0].content).toBe(desc);

    //TODO: add Canonical URL validation when we have final urls
    //expect(helmetProps.link[0].rel).toBe("canonical");
    //expect(helmetProps.link[0].href).toBe("https://sba.gov/eli");
  });

  it("should render a LearningEventHeader", () => {
    const { wrapper } = eventWrapper();

    expect(wrapper.find(LearningEventHeader).exists()).toBe(true);
  });

  it("should render a LearningEventFooter", () => {
    const { wrapper } = eventWrapper();

    expect(wrapper.find(LearningEventFooter).exists()).toBe(true);
  });

  it("should render a <LearningEventManager>", () => {
    const { wrapper } = eventWrapper();

    expect(wrapper.find(LearningEventManager).exists()).toBe(true);
  });
});
