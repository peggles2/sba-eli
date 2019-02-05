const defaultValue = {
  replies: [],
  reply_count: 0,
  discussionErrors: {},
  statusCodes: {}
};

export default function reducer(state = defaultValue, action) {
  switch (action.type) {
    case 'RESET':
      return defaultState();
    case 'GET_DISCUSSION':
      return {
        ...state,
        replies: [],
        reply_count: 0,
        discussionErrors: {},
        statusCodes: {}
      }
    case 'GET_DISCUSSION_FAILURE':
      return {
        ...state,
        replies: [],
        reply_count: 0,
        discussionErrors: {},
        statusCodes: {}
      }
    case 'GET_DISCUSSION_FULFILLED':
      return {
        ...state,
        replies: action.payload.data.replies,
        reply_count: action.payload.data.post_count,
        discussionErrors: {},
        statusCodes: {}
      }
    case 'POST_DISCUSSION':
      return {
        ...state,
        discussionErrors: {
          ...state.discussionErrors,
          [action.payload.config.params.id]: null
        },
        statusCodes: {
          ...state.statusCodes,
          [action.payload.config.params.id]: null
        }
      }
    case 'POST_DISCUSSION_REJECTED':
      return {
        ...state,
        discussionErrors: {
          ...state.discussionErrors,
          [action.payload.config.params.id]: action.payload.response.data.errors
        },
        statusCodes: {
          ...state.statusCodes,
          [action.payload.config.params.id]: action.payload.response.status
        }
      }
    case 'POST_DISCUSSION_FAILURE':
      return {
        ...state,
        discussionErrors: {
          ...state.discussionErrors,
          [action.payload.config.params.id]: action.payload.response.data.errors
        },
        statusCodes: {
          ...state.statusCodes,
          [action.payload.config.params.id]: action.payload.response.status
        }
      }
    case 'POST_DISCUSSION_FULFILLED':
      return {
        ...state,
        discussionErrors: {
          ...state.discussionErrors,
          [action.payload.config.params.id]: null
        },
        statusCodes: {
          ...state.statusCodes,
          [action.payload.config.params.id]: 200
        }
      }
    default:
      break;
  };
  return state;
}