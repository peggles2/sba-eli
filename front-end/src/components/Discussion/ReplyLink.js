import React, {Component} from "react";
import DiscussionPost from "./DiscussionPost";

export class ReplyLink extends Component {

  constructor(props) {
    super(props);

    this.state = {
      showDiscussionReplyBox: false
    };
  }

  discussionReplyClick() {
    this.setState({
      showDiscussionReplyBox: true
    });
  }

  render() {
    const {parent_content_type, post_id} = this.props

    if (this.state.showDiscussionReplyBox) {
      return (
          <DiscussionPost parent_content_type={parent_content_type} post_id={post_id} />
      );
    } else {
      return (
          <a className="reply-link" onClick={() => this.discussionReplyClick()}>
            Reply
          </a>
      );
    }
  }
}

export default ReplyLink