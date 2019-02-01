import axios from 'axios';
import axiosConfig from "./axiosConfig";

export function getDiscussion(content_type, content_id) {
  const url = process.env.REACT_APP_SERVICE_HOST + "/discussions/" + content_type + "/" + content_id

  return {
    type: 'GET_DISCUSSION',
    payload: axios.get(url)
  };
}

export function postDiscussion(bodyData, content_type, content_id) {
  const url = "/discussions/" + content_type + "/" + content_id

  return (dispatch, getState) => {
    return dispatch({
      type: "POST_DISCUSSION",
      payload: axios.post(url, {'discussion_reply': {raw: bodyData}}, axiosConfig(getState(), { id: content_id}))
    });
  };
}