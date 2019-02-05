function defaultState() {
  return {
    learningEvent: {},
    learningEventLoading: false,
    learningEventError: null,
  
    learningEventsCollection: {},
    learningEventsLoading: false,
    learningEventsError: null,
  
    completeEventError: null
  }
}

export default function reducer(state = defaultState(), action) {
  switch (action.type) {
    case 'RESET':
      return defaultState();
    case "GET_LEARNING_EVENT":
      return {
        ...state,
        learningEvent: {},
        learningEventLoading: true,
        learningEventError: null
      };
    case "GET_LEARNING_EVENT_FAILURE":
      return {
        ...state,
        learningEvent: {},
        learningEventLoading: false,
        learningEventError: action.payload
      };
    case "GET_LEARNING_EVENT_FULFILLED":
      return {
        ...state,
        learningEvent: action.payload.data,
        learningEventLoading: false,
        learningEventError: null
      };
    case "GET_LEARNING_EVENTS":
      return {
        ...state,
        learningEventsLoading: true,
        learningEventsError: null
      };
    case "GET_LEARNING_EVENTS_FAILURE":
      return {
        ...state,
        learningEventsLoading: false,
        learningEventsError: action.payload
      };
    case "GET_LEARNING_EVENTS_FULFILLED":
      const { course_id, module_id } = action.payload.config.params;
      return {
        ...state,
        learningEventsLoading: false,
        learningEventsError: null,
        learningEventsCollection: {
          ...state.learningEventsCollection,
          [course_id]: {
            ...state.learningEventsCollection[course_id],
            [module_id]: action.payload.data
          }
        }
      };
    case "COMPLETE_LEARNING_EVENT":
      return {
        ...state,
        completeEventError: null
      };
    case "COMPLETE_LEARNING_EVENT_FAILURE":
      return {
        ...state,
        completeEventError: action.payload
      };
    case "COMPLETE_LEARNING_EVENT_FULFILLED":
      return {
        ...state,
        completeEventError: null
      };
    default:
      break;
  }

  return state;
}
