import React from "react";
import { BrowserRouter as Router } from "react-router-dom";
import { Dropdown } from "semantic-ui-react";
import NavigationLearningPath from "../NavigationLearningPath";
import { shallow, mount } from "enzyme";

import { Provider } from "react-redux";
import { getMockStore } from "../../../store";

describe("NavigationLearningPath", () => {
  const initialState = {
    learningEvent: {
      LearningEvents: []
    },
    learningObjective: {
      adminObjectivesCollection: {}
    },
    learningPath: {
      learningPaths: [
        { id: 1, name: "Learning Path 1" },
        { id: 2, name: "Learning Path 2" },
        { id: 3, name: "Learning Path 3" }
      ]
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

  it("should render a <Dropdown>", () => {
    const wrapper = mount(
      <Provider store={store}>
        <Router>
          <NavigationLearningPath />
        </Router>
      </Provider>
    );

    expect(wrapper.find(Dropdown.Item).length).toEqual(3);
  });
});
