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

export function getLearningPathQuizzes(course_id) {
  return (dispatch, getState) => {
    dispatch(
      {
        type: 'GET_LEARNING_PATH_QUIZZES',
        payload: axios.get(`/learning_paths/${course_id}/quizzes`, axiosConfig(getState()))
      })
  };
}

export function getQuiz(course_id, content_id) {    
  return (dispatch, getState) => {
    dispatch(
      {
        type: 'GET_LEARNING_PATH_QUIZ',
        payload: axios.get(`/learning_paths/${course_id}/quizzes/${content_id}`, axiosConfig(getState()))
      })
  };  
}

export function getQuizSubmissions(course_id, content_id) {
  return (dispatch, getState) => {
    dispatch({
      type: 'GET_LEARNING_PATH_QUIZ_SUBMISSIONS',
      payload: axios.get(`/learning_paths/${course_id}/quizzes/${content_id}/submissions`, axiosConfig(getState()))
    })
  };  
}

export function submitQuiz(course_id, content_id, quiz) {
  quiz.quiz_id = content_id
  return  (dispatch, getState) => {
    dispatch({
      type: 'SUBMIT_QUIZ',
      payload: axios.post(`/learning_paths/${course_id}/quizzes`, quiz, axiosConfig(getState()))
    })
  };  
}

export function clearQuizSubmission() {
  return  {
      type: 'CLEAR_SUBMIT_QUIZ'
    }
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
}

export function getLearningPath(id) {
  return (dispatch, getState) => {
    dispatch({
      type: "GET_LEARNING_PATH",
      payload: axios.get(`/learning_paths/${id}`, axiosConfig(getState()))
    });
  };
}

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
