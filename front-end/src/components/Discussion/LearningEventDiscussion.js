import React, {Component} from "react";
import Discussion from "./Discussion";
import DiscussionPost from "./DiscussionPost";
import {Header, Grid} from "semantic-ui-react";
import {connect} from "react-redux";
import {getDiscussion} from "../../actions/discussionActions";

import "./LearningEventDiscussion.scss";

export class LearningEventDiscussion extends Component {

  commentCount() {
    const {replies, reply_count} = this.props
    if (replies && reply_count > 0) {
      return <span className="comment-count">({reply_count})</span>
    }
    return null
  }

  componentDidUpdate(prevProps) {
    const {learning_event} = this.props
    var content_type = "learning_event_" + learning_event.type
    if (learning_event !== prevProps.learning_event) {
      this.props.dispatch(getDiscussion(content_type, learning_event.id))
    }
  }

  componentDidMount() {
    const {learning_event} = this.props
    var content_type = "learning_event_" + learning_event.type
    if (learning_event !== null) {
      this.props.dispatch(getDiscussion(content_type, learning_event.id))
    }
  }

  render() {
    const {replies, learning_event} = this.props
    var content_type = "learning_event_" + learning_event.type
    return (
        <Grid id="mle-comments">
          <Grid.Row stretched centered columns={15} className="mle-comments-header-row">
            <Grid.Column width={15}>
              <Header as='h3'
                      className="mle-comments-header">Comments {this.commentCount()}</Header>
            </Grid.Column>
          </Grid.Row>
          <DiscussionPost parent_content_type={content_type} 
                          post_id={learning_event.id} /> 
          <Discussion replies={replies}
                      parent_content_type={content_type} />
        </Grid>
    )
  }
}

const mapStateToProps = store => {
  return {
    replies: store.discussion.replies,
    reply_count: store.discussion.reply_count,
    learning_event: store.learningEvent.learningEvent
  }
}

export default connect(mapStateToProps)(LearningEventDiscussion)