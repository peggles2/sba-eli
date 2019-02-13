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
    })
  };
};

export function getLatestUserEnrollment() {
  return(dispatch, getState) => {
    if ( getState().login.isUserLoggedIn ) {
      const { id } = getState().login.userData.user;

      dispatch({
        type: "GET_LATEST_USER_ENROLLMENT",
        payload: axios.get(`users/${id}/enrollments/latest`, axiosConfig(getState())),
      }).then((res) => {
        if(res.value.data === null) {
          return dispatch({ type: "USER_HAS_NOT_STARTED_JOURNEY" });
        } else {
          return dispatch({ type: "USER_HAS_STARTED_JOURNEY" });
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
