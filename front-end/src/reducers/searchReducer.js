const defaultValue = {
  searchLoading: false,
  searchError: null,
  searchResults: [],
  searchMetadata: []
};

export default function reducer(state=defaultValue, action) {
  switch(action.type) {
    case 'SEARCH':
      return {...state, searchResults: [], searchMetadata: [], searchLoading: true, searchError: null};
    case 'SEARCH_REJECTED':
      return {...state, searchResults: [], searchMetadata: [], searchLoading: false, searchError: action.payload};
    case 'SEARCH_FULFILLED':
      return {...state, searchResults: action.payload.data.data, searchMetadata: action.payload.data.meta, searchLoading: false, searchError: null};
    default:
      break;
  }

  return state;
}