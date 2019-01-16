import { applyMiddleware, createStore } from "redux";

import logger from "redux-logger";
import promise from "redux-promise-middleware";
import thunk from 'redux-thunk';
import * as storage from 'redux-storage';
import createEngine from 'redux-storage-engine-localstorage';

import reducer from "./reducers";

const storageReducer = storage.reducer(reducer);
const engine = createEngine('sba-eli-save-key');

// A 2nd argument can be passed to createMiddleware to filter out actions that will not trigger
// a storage event:
// ex:  storage.createMiddleware(engine, ['ACTION_TYPE'])
const storageMiddleware = storage.createMiddleware(engine);

const middleware = applyMiddleware(logger, thunk, promise(), storageMiddleware);

const store = createStore(storageReducer, middleware);
const load = storage.createLoader(engine);

load(store)
  .then((newState) => console.log('Loaded state:', newState))
  .catch(() => console.log('Failed to load previous state'));

export default store;