import React from 'react';

const defaultValue = {
  learningPaths: [],
  learningPathsLoading: false,
  learningPathsError: null
};

export default function reducer(state=defaultValue, action) {
  switch(action.type) {
    case 'GET_LEARNING_PATHS_PENDING':
      return {...state, learningPaths: [], learningPathsLoading: true, learningPathsError: null} 
    case 'GET_LEARNING_PATHS_FAILURE':
      return {...state, learningPaths: [], learningPathsLoading: false, learningPathsError: action.payload} 
    case 'GET_LEARNING_PATHS_SUCCESS':
      return {...state, learningPaths: action.payload, learningPathsLoading: false, learningPathsError: null} 
    default:
      break;
  };
  
  return state;
}