import axios from "axios";
import axiosConfig from './axiosConfig';

export function search(keywords, subject, media_types, duration, per_page=20) {
  var parameters = {
    keywords: keywords,
    subject: subject,
    media_types: media_types,
    duration: duration,
    per_page: 20
  };

  return (dispatch, getState) => {
    dispatch({
      type: "SEARCH",
      payload: axios.get("/search", axiosConfig(getState(), parameters))
    });
  };
}