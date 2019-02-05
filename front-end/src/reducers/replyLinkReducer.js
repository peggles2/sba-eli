const defaultValue = {
};

export default function reducer(state = defaultState(), action) {
  switch (action.type) {
    case 'RESET':
      return defaultState();
    case 'REPLY_TO_DISCUSSION':
      return {...state}
    case 'REPLY_TO_DISCUSSION_FAILURE':
      return {...state}
    case 'REPLY_TO_DISCUSSION_FULFILLED':
      return {...state}
    default:
      break;
  };

  return state;
}