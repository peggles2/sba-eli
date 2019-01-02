import React, {Component} from "react";
import {Grid} from "semantic-ui-react";
import Discussion from "./Discussion";

export default class UserComment extends Component {

  replyLink(parentContentType, parentId, replies) {
    if (parentContentType !== "comment" && replies && replies.replies) {
      return <Grid.Row>
        <a className="reply-link" href={`#/reply?postId=${parentId}`}>Reply</a>
        <Discussion replies={replies}/>
      </Grid.Row>
    }
  }

  userImage(image) {
    if (image) {
      return image
    }
    return "http://picsum.photos/45"
  }

  render() {
    var reply = this.props.replies

    return <Grid.Row className='user-comment' width={16}>
      <Grid.Column width={1}>
        <img className='user-image' src={this.userImage(reply.user_img)} alt={reply.user_name}/>
      </Grid.Column>
      <Grid.Column width={14} className='discussion-post'>
        <Grid>
          <Grid.Row columns={2} className='user'>
            <Grid.Column className='username'>
              {reply.user_name}
              <span className='post-date'>
                {reply.timestamp}
                </span>
            </Grid.Column>
          </Grid.Row>
          <Grid.Row className='user-title'>
            {reply.user_title}
          </Grid.Row>
          <Grid.Row>
            {reply.body}
          </Grid.Row>
          {this.replyLink(this.props.parent_content_type, this.props.parent_id, reply)}
        </Grid>
      </Grid.Column>
    </Grid.Row>
  }
}