const defaultValue = {
    replies: [],
    reply_count: 0
  };
  
  export default function reducer(state=defaultValue, action) {
    switch(action.type) {
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