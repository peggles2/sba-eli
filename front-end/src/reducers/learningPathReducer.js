function defaultState() {
  return {
    learningPaths: [],
    learningPathsLoading: false,
    learningPathsError: null,
  
    learningPath: {},
    learningPathLoading: false,
    learningPathError: null,
  
    topicsList: [],
    pathTopicsLoading: true,
    pathTopicsError: null,
  
    enrollUserError: null
  }
}

export default function reducer(state = defaultState(), action) {
  switch (action.type) {
    case 'RESET':
      return defaultState();
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
    default:
      break;
  }

  return state;
}
