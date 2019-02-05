import axios from "axios";
import axiosConfig from './axiosConfig';

export function getLearningPaths() {
  return (dispatch, getState) => {
    dispatch({
      type: "GET_LEARNING_PATHS",
      payload: axios.get("/learning_paths", axiosConfig(getState()))
    });
  };
}

export function enrollUserInPath(id, state) {
  return {
    type: "ENROLL_USER_IN_PATH",
    payload: axios.post(`/learning_paths/${id}/enroll`, {}, axiosConfig(state))
  };
}

export function getPathWithTopics(id) {
  return (dispatch, getState) => {
    if (getState().login.isUserLoggedIn) {
      dispatch(enrollUserInPath(id, getState()));
    } else {
      dispatch(getLearningPath(id));
      dispatch(getTopicsForPath(id));
    }
  };
};

export function getLearningPath(id) {
  return (dispatch, getState) => {
    dispatch({
      type: "GET_LEARNING_PATH",
      payload: axios.get(`/learning_paths/${id}`, axiosConfig(getState()))
    });
  };
};

export function getLearningPathsProgress() {
  return(dispatch, getState) => {
    dispatch({
      type: "GET_LEARNING_PATHS_PROGRESS",
      payload: axios.get(`/learning_paths/progress`, axiosConfig(getState())),
    });
  };
};

export function getProgressOfLearningPath(id) {
  return(dispatch, getState) => {
    dispatch({
      type: "GET_PROGRESS_OF_LEARNING_PATH",
      payload: axios.get(`/learning_paths/${id}/check_progress`, axiosConfig(getState())),
    });
  };
};

export function getLatestUserEnrollment() {
  return(dispatch, getState) => {
    if ( getState().login.isUserLoggedIn ) {
      const { id } = getState().login.userData.user;

      const request = axios.get(`users/${id}/enrollments/latest`, axiosConfig(getState()))

      dispatch({
        type: "GET_LATEST_USER_ENROLLMENT",
        payload: request,
      });
      request.then((res) => {
        if(res.data === null) {
          dispatch({ type: "USER_HAS_NOT_STARTED_JOURNEY" });
        } else {
          dispatch({ type: "USER_HAS_STARTED_JOURNEY" });
        };
      });
    };
  };
};

export function getTopicsForPath(pathId) {
  const topicParams = {
    course_id: pathId
  };

  return (dispatch, getState) => {
    dispatch({
      type: "GET_TOPICS_FOR_LEARNING_PATH",
      payload: axios.get(
        `/learning_objectives/`,
        axiosConfig(getState(), topicParams)
      )
    });
  };
}
