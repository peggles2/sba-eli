import React, {Component} from "react";
import UserComment from "./UserComment";
import {Grid} from "semantic-ui-react";

export default class Discussion extends Component {

  renderComment(reply, parent_content_type) {
    if (reply && reply.length > 0) {
      return reply.map((reply, index) => {
        return (
            <UserComment key={index}
                         parent_content_type={parent_content_type}
                         replies={reply}/>
        );
      });
    }
    return null;
  }

  render() {
    const {replies, parent_content_type} = this.props
    return (
        <Grid>
          {this.renderComment(replies, parent_content_type)}
        </Grid>
    )
  }
}