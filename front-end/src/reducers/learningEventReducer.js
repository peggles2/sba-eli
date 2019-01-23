const defaultValue = {
  learningEvent: {},
  learningEventLoading: false,
  learningEventError: null,

  learningEvents: [],
  learningEventsLoading: false,
  learningEventsError: null,

  completeEventError: null
};

export default function reducer(state = defaultValue, action) {
  switch (action.type) {
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
        learningEvents: {},
        learningEventsLoading: true,
        learningEventsError: null
      };
    case "GET_LEARNING_EVENTS_FAILURE":
      return {
        ...state,
        learningEvents: {},
        learningEventsLoading: false,
        learningEventsError: action.payload
      };
    case "GET_LEARNING_EVENTS_FULFILLED":
      return {
        ...state,
        learningEvents: action.payload.data,
        learningEventsLoading: false,
        learningEventsError: null
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
