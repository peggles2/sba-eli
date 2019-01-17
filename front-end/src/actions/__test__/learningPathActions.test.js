import * as actions from "../learningPathActions";
import configureMockStore from "redux-mock-store";

import promiseMiddleware from "redux-promise-middleware";
import thunk from "redux-thunk";

const middlewares = [promiseMiddleware(), thunk];
const mockStore = configureMockStore(middlewares);

describe("learningPathActions", () => {
  it("creates GET_LEARNING_PATHS_PENDING when getLearningPaths is dispatched", () => {
    const expectedActions = [{ type: "GET_LEARNING_PATHS_PENDING" }];
    const store = mockStore({
      login: { isUserLoggedin: false }
    });

    store.dispatch(actions.getLearningPaths());
    expect(store.getActions()).toEqual(expectedActions);
  });
});
