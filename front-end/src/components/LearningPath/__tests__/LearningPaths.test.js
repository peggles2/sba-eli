import React from "react";
import { LearningPaths } from "../LearningPaths";
import  ConnectedLearningPathResume, { LearningPathResume } from "../LearningPathResume";
import { Grid } from "semantic-ui-react";
import { Provider } from "react-redux";
import MetaTags from "../../SEO/MetaTags";
import { shallow, mount } from "enzyme";
import { Helmet } from "react-helmet";

describe("LearningPaths", () => {
  it("should render meta tags with Learning Paths specific information", () => {
    const props = {
      getLatestEnrollment: jest.fn(),
    }
    const wrapper = shallow(<LearningPaths {...props}/>);

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
    const props = {
      getLatestEnrollment: jest.fn(),
    }
    const wrapper = shallow(<LearningPaths {...props}/>);

    expect(wrapper.find("div").length).toEqual(1);
  });
});

describe("LearningPaths when user is logged in an started journey", () => {
  it("should render a LearningPathsResume component", () => {
    const props = {
      isUserLoggedIn: true,
      hasUserStartedJourney: true,
      getLatestEnrollment: jest.fn(),
      latestUserEnrollment: {
        course_id: 1,
      },
    }

    const wrapper = shallow(<LearningPaths {...props}/>);

    const inst = wrapper.instance()
    expect(inst.learningPathResume(props.isUserLoggedIn, props.hasUserStartedJourney))
      .toEqual(<Grid.Row><Grid.Column><ConnectedLearningPathResume learningPathId={1} /></Grid.Column></Grid.Row>);
  });
});
