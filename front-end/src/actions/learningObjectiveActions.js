import axios from "axios";
import axiosConfig, { axiosConfigForAdmin } from "./axiosConfig";

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

export function getLearningObjectivesForAdmin(course_id) {
  let params = {
    course_id: course_id
  };

  return dispatch => {
    dispatch({
      type: "GET_LEARNING_OBJECTIVES_ADMIN",
      payload: axios.get(`/learning_objectives/`, axiosConfigForAdmin(params))
    });
  };
}

export function getObjectivesForAdminIfNeeded(course_id) {
  return (dispatch, getState) => {
    if (shouldGetObjectivesForAdmin(course_id, getState())) {
      return dispatch(getLearningObjectivesForAdmin(course_id));
    } else {
      return Promise.resolve();
    }
  };
}

function shouldGetObjectivesForAdmin(course_id, state) {
  return !state.learningObjective.adminObjectivesCollection[course_id];
}
