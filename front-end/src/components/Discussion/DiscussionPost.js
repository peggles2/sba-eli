import React, {Component} from "react";
import {Form, Input, Grid, TextArea} from "semantic-ui-react";
import {connect} from "react-redux";
import {postDiscussion} from '../../actions/discussionActions'

export class DiscussionPost extends Component {

  constructor(props) {
    super(props);

    this.submitPost = this.submitPost.bind(this);
  }

  clearPost(event, post_id) {
    event.preventDefault();
    if (document.getElementById("discussion_input_" + post_id)) {
      document.getElementById("discussion_input_" + post_id).value = "";
    }
  }

  submitPost(event, post_id) {
    event.preventDefault();
    var post_body = document.getElementById("discussion_input_" + post_id)
    if (post_body) {
      var form = event.target
      var post_body_value = document.getElementById("discussion_input_1")
                                    .value
                                    .replace(/(<([^>]+)>)/ig, "");
      this.props.dispatch(
          postDiscussion(
              post_body_value,
              form.parent_content_type.value,
              form.parent_id.value)
      )
      .then(result => {
        console.log(result)
      })
      .catch(error => {
        console.log(error)
        this.state.errors = error
      })
    }
  }

    }
  }

  ifRegistered() {
    const {
      isUserLoggedIn,
      parent_id,
      parent_content_type
    } = this.props
    var post_id = this.props.post_id ? this.props.post_id : 0

    if (isUserLoggedIn) {
      return (
          <Grid.Row className="submission_form" centered>
            <Grid.Column width={15}>
              <Form method="POST" onSubmit={e => this.submitPost(e, post_id)}>
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
