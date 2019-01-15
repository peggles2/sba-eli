import axios from "axios";

const baseUrl = process.env.REACT_APP_SERVICE_HOST;

export function getLearningEvent(course_id, module_id, event_id) {
  const url = baseUrl + `/learning_events/${event_id}`;

  const eventParams = {
    course_id,
    module_id
  };
  return {
    type: "GET_LEARNING_EVENT",
    payload: axios.get(url, { params: eventParams })
  };
}

export function getLearningEvents(course_id, module_id) {
  const url = baseUrl + `/learning_events/`;
  const eventParams = {
    course_id,
    module_id
  };

  return {
    type: "GET_LEARNING_EVENTS",
    payload: axios.get(url, { params: eventParams })
  };
}

export function completeLearningEvent(path_id, objective_id, event_id) {
  const url =
    baseUrl +
    `/learning_paths/${path_id}/learning_objectives/${objective_id}/learning_events/${event_id}/done`;

  return {
    type: "COMPLETE_LEARNING_EVENT",
    payload: axios.post(url)
  };
}
