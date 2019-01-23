import axios from "axios";

function axiosConfig(state, params = null) {
  let authConfig = {};
  if (state.login.isUserLoggedIn) {
    const { access_token } = state.login.userData;
    authConfig = { headers: { AUTHORIZATION: access_token } };
  }

  return {
    params: params,
    baseURL: process.env.REACT_APP_SERVICE_HOST,
    ...authConfig
  };
}

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
