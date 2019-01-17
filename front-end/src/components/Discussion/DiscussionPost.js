import React, {Component} from "react";
import {Form, Input, Grid, TextArea} from "semantic-ui-react";
import {connect} from "react-redux";

export class DiscussionPost extends Component {

  clearPost(event) {
    event.preventDefault();
    document.getElementById('discussion-input').value = ''
  }

  submitPost(event) {
    event.preventDefault();
    //TODO: submit the post to an API
  }

  ifRegistered() {
    if (this.props.isUserLoggedIn) {
      return <Grid.Row centered>
        <Grid.Column width={15}>
          <Form method="POST" action="/discuss">
            <TextArea focus="true" placeholder="Share your thoughts..." id='discussion-input'/>
            <Form.Group className="post_buttons">
              <Form.Button id='clear_post' onClick={this.clearPost}>
                Clear
              </Form.Button>
              <Form.Button primary id='submit_post' onClick={this.submitPost}>
                Add Comment
              </Form.Button>
            </Form.Group>
            <Input type="hidden" name="content_id" value={this.props.parent_id}/>
          </Form>
        </Grid.Column>
      </Grid.Row>
    }
    return null
  }

  render() {
    return (this.ifRegistered(this.props.parent_id))
  }
}

const mapStateToProps = store => {
  return {
    isUserLoggedIn: store.login.isUserLoggedIn
  }
}

export default connect(mapStateToProps)(DiscussionPost)