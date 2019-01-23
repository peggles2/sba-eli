import React, {Component} from "react";
import Discussion from "./Discussion";
import DiscussionPost from "./DiscussionPost";
import {Header, Grid} from "semantic-ui-react";
import {connect} from "react-redux";
import {getDiscussion} from "../../actions/discussionActions";

import "./LearningEventDiscussion.scss";

export class LearningEventDiscussion extends Component {

  commentCount() {
    const properties = this.props
    if (properties.replies && properties.reply_count > 0) {
      return <span className="comment-count">({properties.reply_count})</span>
    }
    return null
  }

  componentDidUpdate(prevProps) {
    const properties = this.props
    if ((properties.parent_id !== prevProps.parent_id) &&
        (properties.parent_content_type !== prevProps.parent_content_type)) {
      properties.dispatch(getDiscussion(properties.parent_content_type, properties.parent_id))
    }
  }

  componentDidMount() {
    const properties = this.props
    if ((properties.parent_id !== null) &&
        (properties.parent_content_type !== null)) {
      properties.dispatch(getDiscussion(properties.parent_content_type, properties.parent_id))
    }
  }

  render() {
    const properties = this.props
    return (
        <Grid id="mle-comments">
          <Grid.Row stretched centered columns={15} className="mle-comments-header-row">
            <Grid.Column width={15}>
              <Header as='h3'
                      className="mle-comments-header">Comments {this.commentCount()}</Header>
            </Grid.Column>
          </Grid.Row>
          <DiscussionPost/>
          <Discussion replies={properties.replies}
                      parent_content_type={properties.parent_content_type}
                      parent_id={properties.parent_id}/>
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