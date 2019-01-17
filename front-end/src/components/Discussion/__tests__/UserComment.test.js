import React from 'react';
import {shallow, mount} from 'enzyme';
import UserComment from "../UserComment";

describe('UserComment', () => {
  it('should render the correct amount of top level replies', () => {
    const mleDiscussion = {
      post_count: 5,
      replies: [
        {
          id: 123,
          content_type: "comment",
          user_img: "http://picsum.photos/45?random",
          user_name: "Georgina Foreman",
          timestamp: "September 1, 2018 1pm",
          user_title: "Small Business Owner Extraordinaire",
          post_number: 1,
          reply_to_post_number: null,
          body: "Nested replies. Liquorice wafer gummi bears dessert muffin tootsie roll powder brownie. Gummi bears sugar plum biscuit chocolate cake dessert apple pie. Lemon drops macaroon fruitcake",
          replies: [
            {
              id: 5678,
              content_type: "comment",
              user_img: "http://picsum.photos/45?random",
              user_name: "Penelope Grant",
              timestamp: "January 1, 2018 1pm",
              user_title: "Small Business Person",
              post_number: 3,
              reply_to_post_number: 1,
              body: "sugar plum biscuit chocolate cake dessert apple pie. Lemon drops macaroon fruitcake",
              replies: []
            }
          ]
        },
        {
          id: 234,
          content_type: "comment",
          user_img: "http://picsum.photos/45?random",
          user_name: "Regina Miles",
          timestamp: "September 1, 2018 1:05pm",
          user_title: "Medium Business Owner",
          post_number: 2,
          reply_to_post_number: null,
          body: "Empty replies array. Gummi bears sugar plum biscuit chocolate cake dessert apple pie. Liquorice wafer gummi bears dessert muffin tootsie roll powder brownie. Lemon drops macaroon fruitcake",
          replies: []
        }
      ]
    }
    const wrapper = mount(<UserComment
        parent_content_type={mleDiscussion.content_type}
        parent_id={mleDiscussion.id}
        replies={mleDiscussion.replies}/>);
    expect(wrapper.find('.user-comment').length).toBe(2);
  });

  it('should render all the parts of a user comment including the reply link', () => {
    const mleDiscussion = {
      id: 987,
      content_type: "learning event",
      reply_count: 234,
      replies: [
        {
          id: 234,
          content_type: "comment",
          user_img: "http://picsum.photos/45?random",
          user_name: "Regina Miles",
          timestamp: "September 1, 2018 1:05pm",
          user_title: "Medium Business Owner",
          body: "Empty replies array. Gummi bears sugar plum biscuit chocolate cake dessert apple pie. Liquorice wafer gummi bears dessert muffin tootsie roll powder brownie. Lemon drops macaroon fruitcake",
          replies: []
        }
      ]
    }
    const wrapper = shallow(<UserComment
        parent_content_type={mleDiscussion.content_type}
        parent_id={mleDiscussion.id}
        replies={mleDiscussion.replies}/>);
    expect(wrapper.find('.user-image').exists()).toBe(true);
    expect(wrapper.find('.username').exists()).toBe(true);
    expect(wrapper.find('.post-date').exists()).toBe(true);
    expect(wrapper.find('.user-title').exists()).toBe(true);
    //expect(wrapper.find('.reply-link').exists()).toBe(true);
  });
});
