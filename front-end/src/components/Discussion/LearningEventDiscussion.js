import React, {Component} from "react";
import Discussion from "./Discussion";
import DiscussionPost from "./DiscussionPost";
import {Header, Grid} from "semantic-ui-react";

import "./LearningEventDiscussion.scss";

export default class LearningEventDiscussion extends Component {

  commentCount(count) {
    if (count > 0) {
      return <span className="comment-count">({count})</span>
    }
    return null
  }

  render() {
    var event = this.props.event;
    var learningEventDiscussion = {
      id: (event.eventContent ? event.eventContent.html_url : 0),
      content_type: "learning event",
      reply_count: 234,
      replies: [
        {
          id: 123,
          content_type: "comment",
          user_img: "http://picsum.photos/45?random",
          user_name: "Georgina Foreman",
          timestamp: "September 1, 2018 1pm",
          user_title: "Small Business Owner Extraordinaire",
          body: "Nested replies. Liquorice wafer gummi bears dessert muffin tootsie roll powder brownie. Gummi bears sugar plum biscuit chocolate cake dessert apple pie. Lemon drops macaroon fruitcake",
          replies: [
            {
              id: 5678,
              content_type: "comment",
              user_img: "http://picsum.photos/45?random",
              user_name: "Penelope Grant",
              timestamp: "January 1, 2018 1pm",
              user_title: "Small Business Person",
              body: "sugar plum biscuit chocolate cake dessert apple pie. Lemon drops macaroon fruitcake",
              replies: []
            },
            {
              id: 9,
              content_type: "comment",
              user_img: "http://picsum.photos/45?random",
              user_name: "Andrea Lopez",
              timestamp: "September 14, 2018 11:05pm",
              user_title: "Business Owner",
              body: "Gummi bears dessert muffin tootsie roll powder brownie fruitcake",
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
          body: "Empty replies array. Gummi bears sugar plum biscuit chocolate cake dessert apple pie. Liquorice wafer gummi bears dessert muffin tootsie roll powder brownie. Lemon drops macaroon fruitcake",
          replies: []
        },
        {
          id: 8,
          content_type: "comment",
          user_img: "http://picsum.photos/45?random",
          user_name: "Amber Riley",
          timestamp: "June 18, 1198 1:05pm",
          user_title: "Early Business Owner",
          body: "Null replies entry. Gummi bears sugar plum biscuit chocolate cake dessert apple pie. Liquorice wafer gummi bears dessert muffin tootsie roll powder brownie. Lemon drops macaroon fruitcake",
          replies: null
        },
        {
          id: 8,
          content_type: "comment",
          user_img: "http://picsum.photos/45?random",
          user_name: "Natalie Jones",
          timestamp: "October 10, 2019 1:05pm",
          user_title: "Business Owner",
          body: "Missing replies entry. gummi bears dessert muffin tootsie roll powdercake"
        }
      ]
    }

    return (
        <Grid className="mle-comments" id="mle-comments">
          <Grid.Row stretched centered columns={15} className="mle-comments-header-row">
            <Grid.Column width={15}>
              <Header as='h3'
                      className="mle-comments-header">Comments {this.commentCount(learningEventDiscussion.reply_count)}</Header>
            </Grid.Column>
          </Grid.Row>
          <DiscussionPost parent={event}/>
          <Discussion replies={learningEventDiscussion}/>
        </Grid>
    )
  }
}  