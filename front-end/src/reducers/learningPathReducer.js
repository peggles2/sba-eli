const defaultValue = {
  learningPaths: [],
  learningPathsLoading: false,
  learningPathsError: null,

  learningPath: {},
  learningPathLoading: false,
  learningPathError: null,

  topicsList: [],
  pathTopicsLoading: true,
  pathTopicsError: null,

  enrollUserError: null,
  quizzes: [],
  quizzesLoading: null,
  quizzesError: null,
  quiz: {},
  quizLoading: null,
  quizError: null,
  quizSubmissions: [],
  quizSubmissionsLoading: null,
  quizSubmissionsError: null,
  submitQuiz: null,
  submitQuizLoading: null,
  submitQuizError: null
};

export default function reducer(state = defaultValue, action) {
  switch (action.type) {
    case "GET_LEARNING_PATHS":
      return {
        ...state,
        learningPaths: [],
        learningPathsLoading: true,
        learningPathsError: null
      };
    case "GET_LEARNING_PATHS_FAILURE":
      return {
        ...state,
        learningPaths: [],
        learningPathsLoading: false,
        learningPathsError: action.payload
      };
    case "GET_LEARNING_PATHS_FULFILLED":
      return {
        ...state,
        learningPaths: action.payload.data,
        learningPathsLoading: false,
        learningPathsError: null
      };
    case "GET_LEARNING_PATH":
      return {
        ...state,
        learningPath: {},
        learningPathLoading: true,
        learningPathError: null
      };
    case "GET_LEARNING_PATH_FAILURE":
      return {
        ...state,
        learningPath: {},
        learningPathLoading: false,
        learningPathError: action.payload
      };
    case "GET_LEARNING_PATH_FULFILLED":
      return {
        ...state,
        learningPath: action.payload.data,
        learningPathLoading: false,
        learningPathError: null
      };
    case "GET_TOPICS_FOR_LEARNING_PATH":
      return {
        ...state,
        topicsList: [],
        pathTopicsLoading: true,
        pathTopicsError: null
      };
    case "GET_TOPICS_FOR_LEARNING_PATH_FAILURE":
      return {
        ...state,
        topicsList: [],
        pathTopicsLoading: false,
        pathTopicsError: action.payload
      };
    case "GET_TOPICS_FOR_LEARNING_PATH_FULFILLED":
      return {
        ...state,
        topicsList: action.payload.data,
        pathTopicsLoading: false,
        pathTopicsError: null
      };
    case "ENROLL_USER_IN_PATH":
      return {
        ...state,
        learningPath: {},
        topicsList: [],
        learningPathsLoading: true,
        pathTopicsLoading: true,
        enrollUserError: null
      };
    case "ENROLL_USER_IN_PATH_FAILURE":
      return {
        ...state,
        learningPath: {},
        topicsList: [],
        learningPathsLoading: false,
        pathTopicsLoading: false,
        enrollUserError: action.payload
      };
    case "ENROLL_USER_IN_PATH_FULFILLED":
      return {
        ...state,
        learningPath: action.payload.data.learningPath,
        topicsList: action.payload.data.topicsList,
        pathTopicsLoading: false,
        learningPathsLoading: false,
        enrollUserError: null
      };
    case 'GET_LEARNING_PATH_QUIZZES':
      return {...state, quizzes: [], quizzesLoading: true, quizzesError: null} 
    case 'GET_LEARNING_PATH_QUIZZES_FAILURE':
      return {...state, quizzes: [], quizzesLoading: false, quizzesError: action.payload} 
    case 'GET_LEARNING_PATH_QUIZZES_FULFILLED':
      return {...state, quizzes: action.payload.data, quizzesLoading: false, quizzesError: null} 
    case 'GET_LEARNING_PATH_QUIZ':
      return {...state, quiz: {}, quizLoading: true, quizError: null} 
    case 'GET_LEARNING_PATH_QUIZ_FAILURE':
      return {...state, quiz: {}, quizLoading: false, quizError: action.payload} 
    case 'GET_LEARNING_PATH_QUIZ_FULFILLED':
      return {...state, quiz: action.payload.data, quizLoading: false, quizError: null} 
    case 'GET_LEARNING_PATH_QUIZ_SUBMISSIONS':
      return {...state, quizSubmissions: [], quizSubmissionsLoading: true, quizSubmissionsError: null} 
    case 'GET_LEARNING_PATH_QUIZ_SUBMISSIONS_FAILURE':
      return {...state, quizSubmissions: [], quizSubmissionsLoading: false, quizSubmissionsError: action.payload} 
    case 'GET_LEARNING_PATH_QUIZ_SUBMISSIONS_FULFILLED':
      return {...state, quizSubmissions: action.payload.data, quizSubmissionsLoading: false, quizSubmissionsError: null} 
    case 'SUBMIT_QUIZ':
      return {...state, submitQuiz: null, submitQuizLoading: true, submitQuizError: null} 
    case 'CLEAR_SUBMIT_QUIZ':
      return {...state, submitQuiz: null, submitQuizLoading: false, submitQuizError: null} 
    case 'SUBMIT_QUIZ_FAILURE':
      return {...state, submitQuiz: null, submitQuizLoading: false, submitQuizError: action.payload} 
    case 'SUBMIT_QUIZ_FULFILLED':
      return {...state, submitQuiz: action.payload.data, submitQuizLoading: false, submitQuizError: null} 
    default:
      break;
  }

  return state;
}
