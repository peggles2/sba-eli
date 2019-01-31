const defaultValue = {
  replies: [],
  reply_count: 0,
  statusCode: null
};

export default function reducer(state = defaultValue, action) {
  switch (action.type) {
    case 'GET_DISCUSSION':
      return {
        ...state,
        replies: [],
        reply_count: 0
      }
    case 'GET_DISCUSSION_FAILURE':
      return {
        ...state,
        replies: [],
        reply_count: 0
      }
    case 'GET_DISCUSSION_FULFILLED':
      return {
        ...state,
        replies: action.payload.data.replies,
        reply_count: action.payload.data.post_count
      }
    case 'POST_DISCUSSION':
      return {
        ...state,
        statusCode: null
      }
    case 'POST_DISCUSSION_FAILURE':
      return {
        ...state,
        statusCode: action.payload.response.data.status
      }
    case 'POST_DISCUSSION_FULFILLED':
      return {
        ...state,
        statusCode: action.payload.response.data.status
      }
    default:
      break;
  };

  return state;
}