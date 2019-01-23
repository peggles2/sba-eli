import { combineReducers } from "redux";

import aboutModal from "./aboutModalReducer";
import learningPath from "./learningPathReducer";
import navbar from "./navbarReducer";
import registration from "./registrationReducer";
import learningEvent from "./learningEventReducer";
import learningObjective from "./learningObjectiveReducer";
import login from "./loginReducer";
import search from "./searchReducer";
import discussion from "./discussionReducer";

export default combineReducers({
  aboutModal,
  learningPath,
  navbar,
  registration,
  learningEvent,
  learningObjective,
  login,
  search,
  discussion
});
