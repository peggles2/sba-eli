import React, {Component} from "react";
import UserComment from "./UserComment";
import {Grid} from "semantic-ui-react";

export default class Discussion extends Component {

  renderComment(parentObject) {
    if (parentObject) {
      return parentObject.replies.map((reply, index) => {
        return (
            <UserComment key={index}
                         parent_content_type={parentObject.content_type}
                         parent_id={parentObject.id}
                         replies={reply}/>
        );
      });
    }
    return null;
  }

  render() {
    return (
        <Grid>
          {this.renderComment(this.props.replies)}
        </Grid>
    )
  }
}