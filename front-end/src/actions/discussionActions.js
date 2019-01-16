import axios from 'axios';

export function getDiscussion(content_type, content_id) {
  const url = process.env.REACT_APP_SERVICE_HOST + "/discussions/" + content_type + "/" + content_id

  return {
    type: 'GET_DISCUSSION', 
    payload: axios.get(url)
  };
}