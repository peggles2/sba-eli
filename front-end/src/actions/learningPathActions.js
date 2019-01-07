import axios from "axios";

const baseUrl = process.env.REACT_APP_SERVICE_HOST;

export function getLearningPaths() {
  return {
    type: "GET_LEARNING_PATHS",
    payload: axios.get(baseUrl + "/learning_paths")
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
