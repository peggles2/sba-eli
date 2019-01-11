import axios from "axios";

const baseUrl = process.env.REACT_APP_SERVICE_HOST;

export function getLearningPaths() {
  return {
    type: "GET_LEARNING_PATHS",
    payload: axios.get(baseUrl + "/learning_paths")
  };
}

export function enrollUserInPath(id) {
  return axios.post(baseUrl + `/learning_paths/${id}/enroll`);
}

export function enrollAndGetLearningPath(id) {
  return dispatch => {
    return enrollUserInPath(id).then(result => {
      dispatch(getLearningPath(id, result));
    });
  };
}

export function getPathWithTopics(id) {
  return (dispatch, getState) => {
    if (getState().login.isUserLoggedIn) {
      dispatch(enrollAndGetLearningPath(id)).then(() =>
        dispatch(getTopicsForPath(id))
      );
    } else {
      dispatch(getLearningPath(id));
      dispatch(getTopicsForPath(id));
    }
  };
}

export function getLearningPath(id) {
  return {
    type: "GET_LEARNING_PATH",
    payload: axios.get(baseUrl + "/learning_paths/" + id)
  };
}

export function getTopicsForPath(pathId) {
  const topicParams = {
    course_id: pathId
  };

  return {
    type: "GET_TOPICS_FOR_LEARNING_PATH",
    payload: axios.get(baseUrl + `/learning_objectives/`, {
      params: topicParams
    }),
    topicPathId: pathId
  };
}
