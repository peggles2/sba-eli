import React from 'react';
import {shallow, mount} from 'enzyme';
import {UserComment} from "../UserComment";

describe('Discussion: User Comment View', () => {
  it('should not render null replies', () => {
    const wrapper = mount(< UserComment
        parent_content_type = "learning_event_Page"
        replies="null"/>);
    expect(wrapper.find('.user-comment').length).toBe(0);
  });

  it('should not render empty replies', () => {
    const wrapper = mount(< UserComment
        parent_content_type="learning_event_Page"
        replies="[]"/>);
    expect(wrapper.find('.user-comment').length).toBe(0);
  });

  it('should render the correct amount of top level replies', () => {
    const comment = {
      id: 123,
      content_type: "comment",
      user_img: "http://picsum.photos/60?random",
      user_name: "Georgina Foreman",
      timestamp: "2019-01-16T22:22:13.619Z",
      user_title: "Small Business Owner Extraordinaire",
      post_number: 1,
      reply_to_post_number: null,
      body: "Nested replies. Liquorice wafer gummi bears dessert muffin tootsie roll powder brownie. Gummi bears sugar plum biscuit chocolate cake dessert apple pie. Lemon drops macaroon fruitcake",
      replies: [{
        id: 5678,
        content_type: "comment",
        user_img: "http://picsum.photos/60?random",
        user_name: "Penelope Grant",
        timestamp: "2019-01-16T22:22:13.619Z",
        user_title: "Small Business Person",
        post_number: 3,
        reply_to_post_number: 1,
        body: "sugar plum biscuit chocolate cake dessert apple pie. Lemon drops macaroon fruitcake",
        replies: []
      },
      {
        id: 4,
        content_type: "comment",
        user_img: "http://picsum.photos/60?random",
        user_name: "Amy Grant",
        timestamp: "2019-01-16T22:22:13.619Z",
        user_title: "Small Business Person",
        post_number: 7,
        reply_to_post_number: 1,
        body: "sugar plum biscuit chocolate cake dessert apple pie. Lemon drops macaroon fruitcake",
        replies: []
      },
      {
        id: 8,
        content_type: "comment",
        user_img: "http://picsum.photos/60?random",
        user_name: "Leslie Grant",
        timestamp: "2019-01-16T22:22:13.619Z",
        user_title: "Small Business Person",
        post_number: 100,
        reply_to_post_number: 1,
        body: "sugar plum biscuit chocolate cake dessert apple pie. Lemon drops macaroon fruitcake",
        replies: []
      }]
    };

    const wrapper = shallow(<UserComment
        parent_content_type="infographic"
        replies={comment}/>);
    expect(wrapper.find('.user-comment').length).toBe(1);
  });
});

describe("Discussion when user is logged in", () => {
  it('should render all the parts of a user comment including the reply link', () => {
    const comment = {
      id: 234,
      content_type: "comment",
      user_img: "http://picsum.photos/60?random",
      user_name: "Angel Alvarez",
      timestamp: "2019-01-16T22:22:13.619Z",
      user_title: "Medium Business Owner",
      post_number: 1,
      reply_to_post_number: null,
      body: "Empty replies array. Gummi bears sugar plum biscuit chocolate cake dessert apple pie. Liquorice wafer gummi bears dessert muffin tootsie roll powder brownie. Lemon drops macaroon fruitcake",
      replies: []
    };
    const wrapper = shallow(<UserComment
        isUserLoggedIn={true}
        parent_content_type="quiz"
        replies={comment}/>);
    expect(wrapper.find('.user-image').exists()).toBe(true);
    expect(wrapper.find('.username').exists()).toBe(true);
    expect(wrapper.find('.post-date').exists()).toBe(true);
    expect(wrapper.find('.user-title').exists()).toBe(true);
    expect(wrapper.find('.reply-link').exists()).toBe(true);
  });
});

describe("Discussion when user is NOT logged in", () => {
  it('should render all the parts of a user comment without the reply link', () => {
    const comment = {
      id: 234,
      content_type: "comment",
      user_img: "http://picsum.photos/45?random",
      user_name: "Misha Wells",
      timestamp: "September 1, 2018 1:05pm",
      user_title: "Medium Business Owner",
      post_number: 1,
      reply_to_post_number: null,
      body: "Empty replies array. Gummi bears sugar plum biscuit chocolate cake dessert apple pie. Liquorice wafer gummi bears dessert muffin tootsie roll powder brownie. Lemon drops macaroon fruitcake",
      replies: []
    };

    const wrapper = shallow(<UserComment
        isUserLoggedIn={false}
        parent_content_type="discussion"
        replies={comment}/>);
    expect(wrapper.find('.user-image').exists()).toBe(true);
    expect(wrapper.find('.username').exists()).toBe(true);
    expect(wrapper.find('.post-date').exists()).toBe(true);
    expect(wrapper.find('.user-title').exists()).toBe(true);
    expect(wrapper.find('.reply-link').exists()).toBe(false);
  });
});
