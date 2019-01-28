import React, {Component} from "react";
import {connect} from "react-redux";
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
    const {parent_content_type, parent_id, post_id} = this.props

    if (this.state.showDiscussionReplyBox) {
      return (
          <DiscussionPost parent_id={parent_id} parent_content_type={parent_content_type} post_id={post_id} />
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

const mapStateToProps = store => {
  return {
    isUserLoggedIn: store.login.isUserLoggedIn
  }
}

export default connect(mapStateToProps)(ReplyLink)