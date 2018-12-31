import axios from 'axios';

const baseUrl = process.env.REACT_APP_SERVICE_HOST

export function getLearningPaths() {
  return {
    type: 'GET_LEARNING_PATHS',
    payload: axios.get(baseUrl + "/learning_paths")
  };
}

export function getLearningPathQuizzes(course_id) {
  return {
    type: 'GET_LEARNING_PATH_QUIZZES',
    payload: axios.get(baseUrl + `/learning_paths/${course_id}/quizzes`)
  };
}

export function getQuiz(course_id, content_id) {    
  return {
    type: 'GET_LEARNING_PATH_QUIZ',
    payload: axios.get(baseUrl + `/learning_paths/${course_id}/quizzes/${content_id}`)
  };  
}