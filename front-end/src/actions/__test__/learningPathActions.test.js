import * as actions from "../learningPathActions";
import axios from "axios";
import configureStore from "redux-mock-store";

import promise from "redux-promise-middleware";
import thunk from "redux-thunk";

const middleware = [(thunk, promise())];
const mockStore = configureStore(middleware);

jest.mock("axios");

describe("learningPathActions", () => {
  it("creates GET_LEARNING_PATHS_FULFILLED on successful request", () => {
    const resp = [{}, {}];
    axios.get.mockResolvedValue(resp);

    const store = mockStore({});

    const expectedActions = [
      { type: "GET_LEARNING_PATHS_PENDING" },
      { type: "GET_LEARNING_PATHS_FULFILLED", payload: resp }
    ];

    return store.dispatch(actions.getLearningPaths()).then(() => {
      const storeActions = store.getActions();
      expect(storeActions).toEqual(expectedActions);
    });
  });
});
