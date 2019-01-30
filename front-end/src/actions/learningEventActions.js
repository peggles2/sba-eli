import axios from "axios";
import axiosConfig from "./axiosConfig";

import { getTopicsForPath } from "./learningPathActions";

export function getLearningEvent(course_id, module_id, event_id) {
  const url = `/learning_events/${event_id}`;

  const eventParams = {
    course_id,
    module_id
  };
  return (dispatch, getState) => {
    return dispatch({
      type: "GET_LEARNING_EVENT",
      payload: axios.get(url, axiosConfig(getState(), eventParams))
    });
  };
}

export function getLearningEventsIfNeeded(course_id, module_id) {
  return (dispatch, getState) => {
    if (shouldGetLearningEvents(course_id, module_id, getState())) {
      return dispatch(getLearningEvents(course_id, module_id));
    } else {
      return Promise.resolve();
    }
  };
}

function shouldGetLearningEvents(course_id, module_id, state) {
  const learningEventsObj =
    state.learningEvent.learningEventsCollection[course_id];

  return !(learningEventsObj && learningEventsObj[module_id]);
}

export function getLearningEvents(course_id, module_id) {
  const url = `/learning_events/`;
  const eventParams = {
    course_id,
    module_id
  };

  return (dispatch, getState) => {
    return dispatch({
      type: "GET_LEARNING_EVENTS",
      payload: axios.get(url, axiosConfig(getState(), eventParams))
    });
  };
}

export function getFirstLearningEvent(course_id, module_id) {
  return (dispatch, getState) => {
    const response = dispatch(getLearningEventsIfNeeded(course_id, module_id));

    response.then(() => {
      const learningEvents = eventsFromCollectionForTopic(
        getState(),
        course_id,
        module_id
      );

      if (learningEvents[0]) {
        dispatch(getLearningEvent(course_id, module_id, learningEvents[0].id));
      }
    });
  };
}

function eventsFromCollectionForTopic(state, course_id, module_id) {
  const eventCollection = state.learningEvent.learningEventsCollection;
  return eventCollection[course_id]
    ? eventCollection[course_id][module_id]
    : [];
}

export function completeLearningEvent(path_id, objective_id, event_id) {
  const url = `/learning_paths/${path_id}/learning_objectives/${objective_id}/learning_events/${event_id}/done`;

  return (dispatch, getState) => {
    const response = dispatch({
      type: "COMPLETE_LEARNING_EVENT",
      payload: axios.post(url, {}, axiosConfig(getState()))
    });

    response.then(() => {
      dispatch(getTopicsForPath(path_id));
    });
  };
}
