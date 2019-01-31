function defaultState() {
  return {
    replies: [],
    reply_count: 0
  }
}
  
export default function reducer(state=defaultState(), action) {
  switch(action.type) {
    case 'RESET':
      return defaultState();
    case 'GET_DISCUSSION':
      return {...state, replies: [], reply_count:0} 
    case 'GET_DISCUSSION_FAILURE':
      return {...state, replies: [], reply_count:0} 
    case 'GET_DISCUSSION_FULFILLED':
      return {...state, replies: action.payload.data.replies, reply_count:action.payload.data.post_count} 
    default:
      break;
  };
  
  return state;
}