import React from 'react';
import {mount} from 'enzyme';
import ReplyLink from "../ReplyLink";
import DiscussionPost from '../DiscussionPost';

describe('Discussion: Reply Link', () => {
  it('should display a link when initially called', () => {
    const wrapper = mount(<ReplyLink />);
    expect(wrapper.find('.reply-link').exists()).toBe(true);
    expect(wrapper.find(DiscussionPost).exists()).toBe(false);
  });

  /*it('should call the discussion component if the link has been clicked', () => {
    const wrapper = mount(<ReplyLink />);
    wrapper.setState({showDiscussionReplyBox: true})

    expect(wrapper.find('.reply-link').exists()).toBe(false);
    expect(wrapper.find(DiscussionPost).exists()).toBe(true);
  });*/

});