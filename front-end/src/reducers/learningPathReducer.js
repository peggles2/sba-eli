const defaultValue = {
  learningPaths: [],
  learningPathsLoading: false,
  learningPathsError: null,

  learningPath: {},
  learningPathLoading: false,
  learningPathError: null,

  learningPathsProgress: [],
  learningPathsProgressLoading: false,
  learningPathsProgressError: null,

  learningPathProgress: {},
  learningPathProgressError: null,

  topicsList: [],
  pathTopicsLoading: true,
  pathTopicsError: null,

  enrollUserError: null,

  latestUserEnrollment: {},
  latestUserEnrollmentError: null,
  hasUserStartedJourney: false,
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
    case "GET_LEARNING_PATHS_PROGRESS":
      return {
        ...state,
        learningPathsProgress: [],
        learningPathsProgressLoading: true,
        learningPathsProgressError: null
      };
    case "GET_LEARNING_PATHS_PROGRESS_FAILURE":
      return {
        ...state,
        learningPathsProgress: [],
        learningPathsProgressLoading: false,
        learningPathsProgressError: action.payload
      };
    case "GET_LEARNING_PATHS_PROGRESS_FULFILLED":
      return {
        ...state,
        learningPathsProgress: action.payload.data,
        learningPathsProgressLoading: false,
        learningPathsProgressError: null
      };
    case "GET_PROGRESS_OF_LEARNING_PATH":
      return {
        ...state,
        learningPathProgress: {},
        learningPathProgressError: null,
      };
    case "GET_PROGRESS_OF_LEARNING_PATH_FAILURE":
      return {
        ...state,
        learningPathProgress: null,
        learningPathProgressError: action.payload.data,
      };
    case "GET_PROGRESS_OF_LEARNING_PATH_FULFILLED":
      return {
        ...state,
        learningPathProgress: action.payload.data,
        learningPathProgressError: null,
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
    case "GET_LATEST_USER_ENROLLMENT":
      return {
        ...state,
        latestUserEnrollment: {},
        latestUserEnrollmentError: null,
      };
    case "GET_LATEST_USER_ENROLLMENT_FAILURE":
      return {
        ...state,
        latestUserEnrollment: {},
        latestUserEnrollmentError: action.payload.data,
      };
    case "GET_LATEST_USER_ENROLLMENT_FULFILLED":
      return {
        ...state,
        latestUserEnrollment: action.payload.data,
        latestUserEnrollmentError: null,
      };
    case "USER_HAS_STARTED_JOURNEY":
      return {
        ...state,
        hasUserStartedJourney: true,
      };
    case "USER_HAS_NOT_STARTED_JOURNEY":
      return {
        ...state,
        hasUserStartedJourney: false,
      };
    default:
      break;
  }

  return state;
}
