import axios from "axios";

const baseUrl = process.env.REACT_APP_SERVICE_HOST;

function axiosHeaders(token) {
  return { AUTHORIZATION: token };
}

export function getLearningPaths() {
  return {
    type: "GET_LEARNING_PATHS",
    payload: axios.get(baseUrl + "/learning_paths")
  };
}

export function enrollUserInPath(id, token) {
  return {
    type: "ENROLL_USER_IN_PATH",
    payload: axios.post(baseUrl + `/learning_paths/${id}/enroll`, {
      headers: axiosHeaders(token)
    })
  };
}

export function getPathWithTopics(id) {
  return (dispatch, getState) => {
    if (getState().login.isUserLoggedIn) {
      const { access_token } = getState().login.userData;
      dispatch(enrollUserInPath(id, access_token));
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
