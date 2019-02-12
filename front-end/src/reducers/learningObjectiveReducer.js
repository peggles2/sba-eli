function defaultState() {
  return {
    learningObjective: {},
    learningObjectiveLoading: false,
    learningObjectiveError: null,

    learningObjectives: [],
    learningObjectivesLoading: false,
    learningObjectivesError: null,

    adminObjectivesCollection: {},
    adminObjectivesErrors: {},
    adminObjectivesLoading: {}
  };
}

export default function reducer(state = defaultState(), action) {
  switch (action.type) {
    case "RESET":
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
    case "GET_LEARNING_OBJECTIVES_ADMIN": {
      const { course_id } = action.payload.config.params;
      return {
        ...state,
        adminObjectivesCollection: {
          ...state.adminObjectivesCollection,
          [course_id]: []
        },
        adminObjectivesErrors: {
          ...state.adminObjectivesErrors,
          [course_id]: null
        },
        adminObjectivesLoading: {
          ...state.adminObjectivesLoading,
          [course_id]: true
        }
      };
    }
    case "GET_LEARNING_OBJECTIVES_ADMIN_FAILURE": {
      const { course_id } = action.payload.config.params;
      return {
        ...state,
        adminObjectivesErrors: {
          ...state.adminObjectivesErrors,
          [course_id]: action.payload
        },
        adminObjectivesLoading: {
          ...state.adminObjectivesLoading,
          [course_id]: false
        }
      };
    }
    case "GET_LEARNING_OBJECTIVES_ADMIN_FULFILLED": {
      const { course_id } = action.payload.config.params;
      return {
        ...state,
        adminObjectivesCollection: {
          ...state.adminObjectivesCollection,
          [course_id]: action.payload.data
        },
        adminObjectivesErrors: {
          ...state.adminObjectivesErrors,
          [course_id]: null
        },
        adminObjectivesLoading: {
          ...state.adminObjectivesLoading,
          [course_id]: false
        }
      };
    }
    default:
      break;
  }

  return state;
}
