import { combineReducers } from "redux";

import aboutModal from "./aboutModalReducer";
import learningPath from "./learningPathReducer";
import navbar from "./navbarReducer";
import registration from "./registrationReducer";
import login from "./loginReducer";
import learningEvent from "./learningEventReducer";

export default combineReducers({
  aboutModal,
  learningPath,
  navbar,
  registration,
  login,
  learningEvent
});
