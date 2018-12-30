import axios from 'axios';

const baseUrl = process.env.REACT_APP_SERVICE_HOST

export function getLearningPaths() {
  return {
    type: 'GET_LEARNING_PATHS',
    payload: axios.get(baseUrl + "/learning_paths")
  };
}