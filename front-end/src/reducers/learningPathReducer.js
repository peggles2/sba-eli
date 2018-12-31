import React from 'react';

const defaultValue = {
  learningPaths: [],
  learningPathsLoading: false,
  learningPathsError: null,
  quizzes: [],
  quiz: {}
};

export default function reducer(state=defaultValue, action) {
  switch(action.type) {
    case 'GET_LEARNING_PATHS':
      return {...state, learningPaths: [], learningPathsLoading: true, learningPathsError: null} 
    case 'GET_LEARNING_PATHS_FAILURE':
      return {...state, learningPaths: [], learningPathsLoading: false, learningPathsError: action.payload} 
    case 'GET_LEARNING_PATHS_FULFILLED':
      return {...state, learningPaths: action.payload.data, learningPathsLoading: false, learningPathsError: null} 
    case 'GET_LEARNING_PATH_QUIZZES':
      return {...state, quizzes: [], quizzesLoading: true, quizzesError: null} 
    case 'GET_LEARNING_PATH_QUIZZES_FAILURE':
      return {...state, quizzes: [], quizzesLoading: false, quizzesError: action.payload} 
    case 'GET_LEARNING_PATH_QUIZZES_FULFILLED':
      return {...state, quizzes: action.payload.data, quizzesLoading: false, quizzesError: null} 
    case 'GET_LEARNING_PATH_QUIZ':
      return {...state, quiz: {}, quizLoading: true, quizError: null} 
    case 'GET_LEARNING_PATH_QUIZ_FAILURE':
      return {...state, quiz: {}, quizLoading: false, quizError: action.payload} 
    case 'GET_LEARNING_PATH_QUIZ_FULFILLED':
      return {...state, quiz: action.payload.data, quizLoading: false, quizError: null} 
    default:
      break;
  };
  
  return state;
}