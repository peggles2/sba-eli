import React, {Component} from "react";
import Discussion from "./Discussion";
import DiscussionPost from "./DiscussionPost";
import {Header, Grid} from "semantic-ui-react";
import {connect} from "react-redux";

import "./LearningEventDiscussion.scss";

export class LearningEventDiscussion extends Component {

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
      reply_count: 4,
      replies: this.props.replies
    }

    return (
        <Grid id="mle-comments">
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
const mapStateToProps = store => {
  return {
    replies: store.discussion.replies
    
  }
}

export default connect(mapStateToProps)(LearningEventDiscussion)