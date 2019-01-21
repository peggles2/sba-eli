import axios from "axios";
import axiosConfig from './axiosConfig';

export function getLearningEvent(course_id, module_id, event_id) {
  const url = `/learning_events/${event_id}`;

  const eventParams = {
    course_id,
    module_id
  };
  return (dispatch, getState) => {
    dispatch({
      type: "GET_LEARNING_EVENT",
      payload: axios.get(url, axiosConfig(getState(), eventParams))
    });
  };
}

export function getLearningEvents(course_id, module_id) {
  const url = `/learning_events/`;
  const eventParams = {
    course_id,
    module_id
  };

  return (dispatch, getState) => {
    dispatch({
      type: "GET_LEARNING_EVENTS",
      payload: axios.get(url, axiosConfig(getState(), eventParams))
    });
  };
}

export function completeLearningEvent(path_id, objective_id, event_id) {
  const url = `/learning_paths/${path_id}/learning_objectives/${objective_id}/learning_events/${event_id}/done`;

  return (dispatch, getState) => {
    dispatch({
      type: "COMPLETE_LEARNING_EVENT",
      payload: axios.post(url, {}, axiosConfig(getState()))
    });
  };
}
