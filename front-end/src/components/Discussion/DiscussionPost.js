import React, {Component} from "react";
import {Form, Grid, Message, TextArea} from "semantic-ui-react";
import {connect} from "react-redux";
import {postDiscussion} from "../../actions/discussionActions"

export class DiscussionPost extends Component {

  constructor(props) {
    super(props);

    this.submitPost = this.submitPost.bind(this);
  }

  componentDidUpdate(prevProps) {
    if (this.props.post_id !== prevProps.post_id) {
      this.clearPostById(this.props.post_id)
    }
  }

  clearPost(event, post_id) {
    event.preventDefault();
    this.clearPostById(post_id)
  }

  clearPostById(post_id) {
    if (post_id && document.getElementById("discussion_input_" + post_id)) {
      document.getElementById("discussion_input_" + post_id).value = "";
    }
  }

  submitPost(event, post_id, parent_content_type) {
    event.preventDefault();
    let post_body = document.getElementById("discussion_input_" + post_id)
    if (post_body) {
      let post_body_value = post_body.value.replace(/(<([^>]+)>)/ig, "");

      this.props.dispatch(
          postDiscussion(
              post_body_value,
              parent_content_type,
              post_id)
      )
    }
  }

  getErrorList(post_id) {
    const discussionErrors = this.props.discussionErrors[post_id]

    if (discussionErrors && discussionErrors.raw) {
      return discussionErrors.raw.map(function (error, index) {
        return <li key={index}>{error}</li>
      })
    }
  }

  getMessaging(post_id) {
    const statusCode = this.props.statusCodes[post_id]

    if (statusCode && statusCode !== null) {
      if (statusCode !== 200) {
        return <Message negative>
          <Message.Header>We're sorry, there was an error posting your comment</Message.Header>
          <ul>{this.getErrorList(post_id)}</ul>
        </Message>
      } else {
        this.clearPostById(post_id)
        return <Message positive>
          <Message.Header>Post submitted</Message.Header>
          <p>If you are new to our system, your post will be moderated before going live</p>
        </Message>
      }
    }
  }

  ifRegistered() {
    const {
      isUserLoggedIn,
      parent_content_type
    } = this.props
    let post_id = this.props.post_id ? this.props.post_id : 0

    if (isUserLoggedIn) {
      return (
          <Grid.Row className="submission_form" centered>
            <Grid.Column width={15}>
              {this.getMessaging(post_id)}
              <Form method="POST" onSubmit={e => this.submitPost(e, post_id, parent_content_type)}>
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
                  <Form.Button primary id={"submit_post_" + post_id}>
                    Add Comment
                  </Form.Button>
                </Form.Group>
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
    isUserLoggedIn: store.login.isUserLoggedIn,
    statusCodes: store.discussion.statusCodes,
    discussionErrors: store.discussion.discussionErrors
  };
};

export default connect(mapStateToProps)(DiscussionPost);
