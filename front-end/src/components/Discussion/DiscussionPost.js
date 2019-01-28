import React, {Component} from "react";
import {Form, Input, Grid, TextArea} from "semantic-ui-react";
import {connect} from "react-redux";

export class DiscussionPost extends Component {
  clearPost(event, post_id) {
    event.preventDefault();
    if (document.getElementById("discussion_input_" + post_id)) {
      document.getElementById("discussion_input_" + post_id).value = "";
    }
  }

  submitPost(event) {
    event.preventDefault();
    //TODO: submit the post to an API
  }

  ifRegistered() {
    const {isUserLoggedIn, parent_id, parent_content_type} = this.props
    var post_id = this.props.post_id ? this.props.post_id : 0
    if (isUserLoggedIn) {
      return (
          <Grid.Row centered>
            <Grid.Column width={15}>
              <Form method="POST" action="/discuss">
              <TextArea
                  focus="true"
                  placeholder="Share your thoughts..."
                  className="discussion_input"
                  id={"discussion_input_" + post_id}
              />
                <Form.Group className="post_buttons">
                  <Form.Button id={"clear_post_" + post_id} onClick={e => this.clearPost(e, post_id)}>
                    Clear
                  </Form.Button>
                  <Form.Button primary id="submit_post" onClick={this.submitPost}>
                    Add Comment
                  </Form.Button>
                </Form.Group>
                <Input
                    type="hidden"
                    name="parent_id"
                    value={parent_id}
                />
                <Input
                    type="hidden"
                    name="parent_content_type"
                    value={parent_content_type}
                />
              </Form>
            </Grid.Column>
          </Grid.Row>
      );
    }
    return null;
  }

  render() {
    return this.ifRegistered();
  }
}

const mapStateToProps = store => {
  return {
    isUserLoggedIn: store.login.isUserLoggedIn
  };
};

export default connect(mapStateToProps)(DiscussionPost);
