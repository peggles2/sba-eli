function defaultState() {
  return {
    learningObjective: {},
    learningObjectiveLoading: false,
    learningObjectiveError: null,
  
    learningObjectives: [],
    learningObjectivesLoading: false,
    learningObjectivesError: null
  }
}

export default function reducer(state = defaultState(), action) {
  switch (action.type) {
    case 'RESET':
      return defaultState();
    case "GET_LEARNING_OBJECTIVE":
      return {
        ...state,
        learningObjective: {},
        learningObjectiveLoading: true,
        learningObjectiveError: null
      };
    case "GET_LEARNING_OBJECTIVE_FAILURE":
      return {
        ...state,
        learningObjective: {},
        learningObjectiveLoading: false,
        learningObjectiveError: action.payload
      };
    case "GET_LEARNING_OBJECTIVE_FULFILLED":
      return {
        ...state,
        learningObjective: action.payload.data,
        learningObjectiveLoading: false,
        learningObjectiveError: null
      };
    case "GET_LEARNING_OBJECTIVES":
      return {
        ...state,
        learningObjectives: [],
        learningObjectivesLoading: true,
        learningObjectivesError: null
      };
    case "GET_LEARNING_OBJECTIVES_FAILURE":
      return {
        ...state,
        learningObjectives: [],
        learningObjectivesLoading: false,
        learningObjectivesError: action.payload
      };
    case "GET_LEARNING_OBJECTIVES_FULFILLED":
      return {
        ...state,
        learningObjectives: action.payload.data,
        learningObjectivesLoading: false,
        learningObjectivesError: null
      };
    default:
      break;
  }

  return state;
}