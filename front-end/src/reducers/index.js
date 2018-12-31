import { combineReducers } from "redux";

import aboutModal from "./aboutModalReducer";
import learningPath from "./learningPathReducer";

export default combineReducers({
  aboutModal,
  learningPath
});