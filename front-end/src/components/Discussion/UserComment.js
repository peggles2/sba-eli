import React, {Component} from "react";
import {Grid, Image} from "semantic-ui-react";
import {connect} from "react-redux";
import Discussion from "./Discussion";

export class UserComment extends Component {

  replyLink(parentContentType, parent_id, reply) {
    const replyLink = this.props.isUserLoggedIn 
                      ? <a className="reply-link" href={`#/discussion/content_type/${parent_id}`}>Reply</a>
                      : null
    if (parentContentType !== "comment" && reply && reply.replies) {
      return <Grid.Row>
        {replyLink}
        <Discussion replies={reply}/>
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
        <Image className='user-image' 
               size='tiny' 
               circular  
               verticalAlign='middle' 
               src={this.userImage(reply.user_img)} 
               alt={reply.user_name}/>
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
const mapStateToProps = store => {
  return {
    isUserLoggedIn: store.login.isUserLoggedIn
  }
}

export default connect(mapStateToProps)(UserComment)