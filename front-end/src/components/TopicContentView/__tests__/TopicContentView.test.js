import React from "react";
import { mount } from "enzyme";
import TopicContentView from "../TopicContentView";
import { Item } from "semantic-ui-react";

import { Provider } from "react-redux";
import { getMockStore } from "../../../store";

describe("TopicContentView", () => {
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

  it("should render a <Item.Group>", () => {
    const topicsList = [{ name: "Test", id: 1 }];
    const wrapper = mount(
      <Provider store={store}>
        <TopicContentView course_id={1} topicsList={topicsList} />
      </Provider>
    );

    expect(wrapper.find(Item.Group).exists()).toBe(true);
  });
});
