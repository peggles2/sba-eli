import React, {Component} from "react";
import {Form, Input, Grid, TextArea} from "semantic-ui-react";

export default class DiscussionPost extends Component {
  constructor(props) {
    super(props);

    this.state = {
      //TODO: update this logic when we have signon working
      signedIn: true,
      parentId: this.props.parent.id
    };
  };

  clearPost(event) {
    event.preventDefault();
    document.getElementById('discussion-input').value = ''
  }

  submitPost(event) {
    event.preventDefault();
    //TODO: submit the post to an API
  }

  ifRegistered() {
    if (this.state.signedIn) { 
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
            <Input type="hidden" name="content_id" value={this.state.parentId}/>
          </Form>
        </Grid.Column>
      </Grid.Row>
    }
    return ''
  }

  render() {
    return (this.ifRegistered())
  }
}  