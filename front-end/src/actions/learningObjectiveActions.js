import axios from "axios";
import axiosConfig from "./axiosConfig";

export function getLearningObjective(objective_id, course_id) {
  let params = {
    course_id: course_id
  };

  return (dispatch, getState) => {
    dispatch({
      type: "GET_LEARNING_OBJECTIVE",
      payload: axios.get(
        `/learning_objectives/${objective_id}`,
        axiosConfig(getState(), params)
      )
    });
  };
}

export function getLearningObjectives(course_id) {
  let params = {
    course_id: course_id
  };

  return (dispatch, getState) => {
    dispatch({
      type: "GET_LEARNING_OBJECTIVES",
      payload: axios.get(
        `/learning_objectives/`,
        axiosConfig(getState(), params)
      )
    });
  };
}
