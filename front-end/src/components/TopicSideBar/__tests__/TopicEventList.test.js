import React from "react";
import { shallow, mount } from "enzyme";
import { Item } from "semantic-ui-react";
import ConnectedTopicEventList, { TopicEventList } from "../TopicEventList";
import { Link, MemoryRouter } from "react-router-dom";

import { Provider } from "react-redux";
import { getMockStore } from "../../../store";

describe("TopicProgressBar", () => {
  const initialState = {
    learningEvent: {
      learningEventsCollection: {}
    },
    learningObjective: {
      learningObjectives: []
    },
    learningPath: {
      learningPaths: []
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

  it("should render an Item.Group", () => {
    const props = {
      course_id: 1,
      module_id: 1,
      dispatch: () => {},
      learningEventsCollection: { 1: { 1: [{ id: 1, title: "Test" }] } }
    };

    const wrapper = shallow(<TopicEventList {...props} />);
    // const eventsList = [];
    // wrapper.setState({ eventsList });

    expect(wrapper.find(Item.Group).exists()).toBe(true);
  });

  it("should render a Link with the proper title", () => {
    const props = {
      course_id: 1,
      module_id: 1,
      learningEventsCollection: { 1: { 1: [{ id: 1, title: "Test" }] } }
    };

    const wrapper = mount(
      <Provider store={store}>
        <MemoryRouter>
          <ConnectedTopicEventList {...props} />
        </MemoryRouter>
      </Provider>
    );

    expect(
      wrapper
        .find(Link)
        .at(0)
        .text()
    ).toMatch(/Learning Event/);
  });

  //Expand to handle getting/mocking eventsList properly
});
