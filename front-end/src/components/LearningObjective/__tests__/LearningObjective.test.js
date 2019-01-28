import React from "react";
import ConnectedLearningObjective, {
  LearningObjective
} from "../LearningObjective";
import { LearningEventsList } from "../../LearningEvent/LearningEventsList";
import MetaTags from "../../SEO/MetaTags";
import { shallow, mount } from "enzyme";

import { Provider } from "react-redux";
import { getMockStore } from "../../../store";
import { Helmet } from "react-helmet";

describe("LearningObjective", () => {
  const title = "Learning Objective!";
  const desc = "learning objective description text";

  const initialState = {
    learningEvent: {
      learningEventsCollection: {}
    },
    learningObjective: {
      learningObjective: {
        name: title,
        description: desc
      }
    },
    login: {
      isUserLoggedIn: true,
      userData: {
        access_token: ""
      }
    }
  };
  const mockStore = getMockStore();
  let store;

  beforeEach(() => {
    store = mockStore(initialState);
  });

  it("should render meta tags with Learning Objective specific information", () => {
    const match = { params: { id: 1 } };
    const learningObjective = { name: title, description: desc };

    const wrapper = shallow(
      <LearningObjective
        match={match}
        learningObjective={learningObjective}
        dispatch={() => {}}
      />
    );
    wrapper.instance().setState({ learningObjective });

    expect(wrapper.find(MetaTags).exists()).toBe(true);
    const metaWrapper = wrapper.find(MetaTags).dive();
    const helmetProps = metaWrapper.find(Helmet).props();

    expect(helmetProps.title).toBe(title);
    expect(helmetProps.meta[0].name).toBe("description");
    expect(helmetProps.meta[0].content).toBe(desc);

    //TODO: add Canonical URL validation when we have final urls
  });

  it("should render a single h1 and it should display the objective title", () => {
    const match = { params: { id: 1 } };

    const wrapper = mount(
      <Provider store={store}>
        <ConnectedLearningObjective match={match} />
      </Provider>
    );

    expect(wrapper.find("h1").exists()).toBe(true);
    expect(wrapper.find("h1").length).toEqual(1);
    expect(wrapper.find("h1").text()).toEqual(title);
  });

  it("should render a <LearningEventsList>", () => {
    const match = { params: { id: 1 } };
    const wrapper = mount(
      <Provider store={store}>
        <ConnectedLearningObjective match={match} />
      </Provider>
    );

    expect(wrapper.find(LearningEventsList).exists()).toBe(true);
  });
});
