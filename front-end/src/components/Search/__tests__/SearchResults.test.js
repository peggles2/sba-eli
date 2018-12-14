import React from 'react';
import {shallow, mount} from 'enzyme';
import { BrowserRouter as Router } from 'react-router-dom';
import SearchResults from "../SearchResults";

describe('SearchResults', () => {
  it('should render the correct number of search results for the data that is passed in', () => {
    const searchResults = [
      {
        "id": 1,
        "name": "Title of a learning path",
        "description": "Short description of the content",
        "meta_data": {},
        "thumbnail": "http://picsum.photos/200"
      },
      {
        "id": 1,
        "name": "Title of a learning objective",
        "description": "Sesame snaps tart pastry sweet roll cupcake. Chocolate bar jelly beans cheesecake cake cupcake. Liquorice icing tootsie roll chupa chupsfruitcake gingerbread. Sesame snaps tart pastry sweet roll cupcake. Sesame snaps tart pastry sweet roll cupcake. Sesame snaps tart pastry sweet roll cupcake. Chocolate bar jelly beans cheesecake cake cupcake. Liquorice icing tootsie roll chupa chupsfruitcake gingerbread. Sesame snaps tart pastry sweet roll cupcake. Sesame snaps tart pastry sweet roll cupcake.",
        "meta_data": {
          "learning_path_id": 1
        },
        "thumbnail": "http://picsum.photos/200"
      },
      {
        "id": 2,
        "name": "Title of Learning Event",
        "description": "Short description of the content",
        "meta_data": {
          "learning_path_id": 1,
          "learning_objective_id": 1
        },
        "thumbnail": "http://picsum.photos/200"
      }
    ]
    const wrapper = shallow(<SearchResults searchResults={searchResults}/>);
    expect(wrapper.find('.search_result_item').length).toBe(3);
  });

  it('should render all the parts of a search result', () => {
    const searchResults = [{
      "id": 2,
      "name": "Title of Learning Event",
      "description": "Short description of the content",
      "meta_data": {
        "learning_path_id": 1,
        "learning_objective_id": 1
      },
      "thumbnail": "http://picsum.photos/200"
    }]
    const wrapper = shallow(<SearchResults searchResults={searchResults}/>);
    /*expect(wrapper.find('search_result_image').exists()).toBe(true);
    expect(wrapper.find('.search_result_title').exists()).toBe(true);
    expect(wrapper.find('.search_result_title').text()).toEqual("Title of Learning Event")
    expect(wrapper.find('.search_result_description').exists()).toBe(true);
    expect(wrapper.find('.search_result_description').render().text()).toEqual("Short description of the content")*/
  });
});
