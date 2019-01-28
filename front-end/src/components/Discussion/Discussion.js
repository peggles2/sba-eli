import React, {Component} from "react";
import UserComment from "./UserComment";
import {Grid} from "semantic-ui-react";

export default class Discussion extends Component {

  renderComment(reply, parent_content_type, parent_id) {
    if (reply && reply.length > 0) {
      return reply.map((reply, index) => {
        return (
            <UserComment key={index}
                         post_id={index + 1}
                         parent_content_type={parent_content_type}
                         parent_id={parent_id}
                         replies={reply}/>
        );
      });
    }
    return null;
  }

  render() {
    return (
        <Grid>
          {this.renderComment(this.props.replies, this.props.parent_content_type, this.props.parent_id)}
        </Grid>
    )
  }
}