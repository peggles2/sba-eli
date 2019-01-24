import React from "react";
import { List } from "semantic-ui-react";
import ConnectedLearningObjectivesList, { LearningObjectivesList } from "../LearningObjectivesList";
import { shallow, mount } from "enzyme";

import { Provider } from 'react-redux'
import { getMockStore } from '../../../store';

describe("LearningObjectivesList", () => {
  const initialState = {
    learningEvent: {
      LearningEvents: []
    },
    learningObjective: {
      learningObjectives: []
    },
    login: {
      isUserLoggedIn: true,
      userData: {
        access_token: ''
      }
    }
  }
  const mockStore = getMockStore();
  let store;

  beforeEach(()=> {
    store = mockStore(initialState);
  })

  it("should render a <List>", () => {
    const wrapper = shallow(<LearningObjectivesList dispatch={()=>{}} />);

    expect(wrapper.find(List).length).toEqual(1);
  });

  it("should render at least one <li>", () => {
    const wrapper = mount(<Provider store={store}><ConnectedLearningObjectivesList course_id="1" /></Provider>);

    expect(wrapper.find(List).length).toBeGreaterThanOrEqual(1);
  });
});
