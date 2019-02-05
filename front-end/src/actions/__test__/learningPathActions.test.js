import * as actions from "../learningPathActions";
import { getLearningPathProgress } from "../learningPathActions";
import configureMockStore from "redux-mock-store";
import promiseMiddleware from "redux-promise-middleware";
import thunk from "redux-thunk";

const middlewares = [promiseMiddleware(), thunk];
const mockStore = configureMockStore(middlewares);

describe("learningPathActions", () => {
  it("creates GET_LEARNING_PATHS_PENDING when getLearningPaths is dispatched", () => {
    const expectedActions = [{ type: "GET_LEARNING_PATHS_PENDING" }];
    const store = mockStore({
      login: { isUserLoggedIn: false }
    });

    store.dispatch(actions.getLearningPaths());
    expect(store.getActions()).toEqual(expectedActions);
  });
});

describe("getLearningPathsProgress", () => {
  it("should get learning path progress for a logged in user", () => {
    const expectedActions = [{ type: "GET_LEARNING_PATHS_PROGRESS_PENDING" }];

    const store = mockStore({
      login: { isUserLoggedIn: true, userData: { access_token: "abcdef" } },
      learningPathsProgress: []
    });

    store.dispatch(actions.getLearningPathsProgress());
    expect(store.getActions()).toEqual(expectedActions);
  });
});
