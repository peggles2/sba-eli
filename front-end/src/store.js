import { applyMiddleware, createStore } from "redux";

import logger from "redux-logger";
import promise from "redux-promise-middleware";
import thunk from 'redux-thunk';
import * as storage from 'redux-storage';
import createEngine from 'redux-storage-engine-localstorage';
import configureStore from 'redux-mock-store';

import reducer from "./reducers";

export function getStore() {
  const storageReducer = storage.reducer(reducer);
  const engine = createEngine('sba-eli-save-key');

  // A 2nd argument can be passed to createMiddleware to filter out actions that will not trigger
  // a storage event:
  // ex:  storage.createMiddleware(engine, ['ACTION_TYPE'])
  const storageMiddleware = storage.createMiddleware(engine);

  let middleware = [thunk, promise(), storageMiddleware]
  
  if (process.env.NODE_ENV !== 'production') {   
    middleware = [...middleware, logger]
  }

  const store = createStore(storageReducer, applyMiddleware(...middleware));
  const load = storage.createLoader(engine);

  load(store)
    .then((newState) => console.log('Loaded state:', newState))
    .catch(() => console.log('Failed to load previous state'));

  return store;
}

export function getMockStore() {
  return configureStore(
    [ thunk, promise() ]
  );
}