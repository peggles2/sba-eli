import React, {Component} from "react";
import Discussion from "./Discussion";
import DiscussionPost from "./DiscussionPost";
import {Header, Grid} from "semantic-ui-react";
import {connect} from "react-redux";
import {getDiscussion} from "../../actions/discussionActions";

import "./LearningEventDiscussion.scss";

export class LearningEventDiscussion extends Component {

  commentCount() {
    if (this.props.replies && this.props.reply_count > 0) {
      return <span className="comment-count">({this.props.reply_count})</span>
    }
    return null
  }

  componentDidUpdate(prevProps) { 
    if((this.props.parent_id !== prevProps.parent_id) && 
       (this.props.parent_content_type !== prevProps.parent_content_type)) {
      this.props.dispatch(getDiscussion(this.props.parent_content_type, this.props.parent_id))
    }
  }

  render() {
    return ( 
        <Grid id="mle-comments">
          <Grid.Row stretched centered columns={15} className="mle-comments-header-row">
            <Grid.Column width={15}>
              <Header as='h3'
                      className="mle-comments-header">Comments {this.commentCount()}</Header>
            </Grid.Column>
          </Grid.Row>
          <DiscussionPost />
          <Discussion replies={this.props.replies} parent_content_type={this.props.parent_content_type} parent_id={this.props.parent_id} />
        </Grid>
    )
  }
}  

const mapStateToProps = store => {
  return {
    replies: store.discussion.replies,
    reply_count: store.discussion.reply_count
  }
}

export default connect(mapStateToProps)(LearningEventDiscussion)