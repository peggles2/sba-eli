import React, {Component} from "react";
import {Grid, Image} from "semantic-ui-react";
import {connect} from "react-redux";
import Discussion from "./Discussion";
import ReplyLink from "./ReplyLink";

export class UserComment extends Component {

  replyLink(parent_content_type, parent_id, reply) {
    const replyLink = this.props.isUserLoggedIn
        ? <ReplyLink parent_content_type={reply.content_type} parent_id={parent_id} />
        : null
    if (parent_content_type !== "comment" && reply && reply.replies) {
      return <Grid.Row>
        {replyLink}
        <Discussion replies={reply.replies} parent_content_type={reply.content_type} parent_id={reply.id}/>
      </Grid.Row>
    }
  }

  userImage(image) {
    if (image) {
      return image
    }
    return "http://picsum.photos/45"
  }

  formatDate(timestamp) {
    var month = [];
    month[0] = "January";
    month[1] = "February";
    month[2] = "March";
    month[3] = "April";
    month[4] = "May";
    month[5] = "June";
    month[6] = "July";
    month[7] = "August";
    month[8] = "September";
    month[9] = "October";
    month[10] = "November";
    month[11] = "December";

    if (timestamp) {
      const date = new Date(timestamp)
      return month[date.getMonth()] + " " + date.getDate() + ", " + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes()
    }
  }

  render() {
    const {replies, parent_id, parent_content_type, post_id} = this.props
    
    if (replies && replies !== null && replies.id) {
      return <Grid.Row className='user-comment' width={16}>
        <Grid.Column width={1}>
          <Image className='user-image'
                size='tiny'
                circular
                verticalAlign='middle'
                src={this.userImage(replies.user_img)}
                alt={replies.user_name}/>
        </Grid.Column>
        <Grid.Column width={14} className='discussion-post'>
          <Grid>
            <Grid.Row columns={2} className='user'>
              <Grid.Column className='username'>
                {replies.user_name}
                <span className='post-date'>
                  {this.formatDate(replies.timestamp)}
                  </span>
              </Grid.Column>
            </Grid.Row>
            <Grid.Row className='user-title'>
              {replies.user_title}
            </Grid.Row>
            <Grid.Row>
              {replies.body}
            </Grid.Row>
            {this.replyLink(post_id, parent_content_type, parent_id, replies)}
          </Grid>
        </Grid.Column>
      </Grid.Row>
    } 
    return null;
  }
}

const mapStateToProps = store => {
  return {
    isUserLoggedIn: store.login.isUserLoggedIn
  }
}

export default connect(mapStateToProps)(UserComment)