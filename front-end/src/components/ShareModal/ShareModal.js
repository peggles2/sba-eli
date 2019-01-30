import React from 'react';
import {Button, Grid, Icon, Input, Modal} from 'semantic-ui-react';
import {
  FacebookShareButton,
  EmailShareButton,
  LinkedinShareButton,
  TwitterShareButton,
} from 'react-share';

import "./ShareModal.scss"

export default class ShareModal extends React.Component {

  constructor(props) {
    super(props);
    this.locationRef = React.createRef();
  }

  state = {
    modalOpen: false,
    textHasBeenCopied: ''
  }

  handleOpen = () => this.setState({ modalOpen: true })

  handleClose = () => {
    this.setState({ modalOpen: false })
    this.setState({ textHasBeenCopied: '' })
  }

  handleCopy = (e) =>  {
    var locationValue = this.locationRef.current;
    locationValue.select();
    document.execCommand("copy");
    this.setState({ textHasBeenCopied: 'Link has been copied to clipboard!' })
  }

  render() {
    return <Modal trigger={<Button onClick={this.handleOpen} className="share-modal-button mobile hidden">Share &nbsp; <Icon name={"share"} /></Button>}
                  id="ShareModal"
                  open={this.state.modalOpen}
                  onClose={this.handleClose}
                  closeOnDimmerClick={false}
                  size={'tiny'} >
      <Modal.Header>
        <Grid>
          <Grid.Row>
            <Grid.Column width={15}>
              Share this {this.props.contentType}
            </Grid.Column>
            <Grid.Column width={1}>
              <Button content='X' size={'small'} onClick={this.handleClose} className="share-close-button" />
            </Grid.Column>
          </Grid.Row>
        </Grid>
      </Modal.Header>

        <p>
          {this.props.description}
        </p>
        <div className="share-model-button-group">
          <FacebookShareButton
            url={this.props.location}
            quote={this.props.description}
            className="share-modal-share">
            <Icon
              name="facebook official"
              size="huge"
              className="share-facebook-icon" />
              <p>Facebook</p>
          </FacebookShareButton>
          <TwitterShareButton
            url={this.props.location}
            title={this.props.description}
            className="share-modal-share">
            <Icon
              name="twitter"
              size="huge"
              className="share-twitter-icon" />
              <p>Twitter</p>
          </TwitterShareButton>
          <LinkedinShareButton
            url={this.props.location}
            title={this.props.description}
            windowWidth={750}
            windowHeight={600}
            className="share-modal-share">
            <Icon
              name="linkedin"
              size="huge"
              className="share-linkedin-icon" />
              <p>LinkedIn</p>
          </LinkedinShareButton>
          <EmailShareButton
            subject={this.props.title}
            body={this.props.description}
            url={this.props.location}
            className="share-modal-share">
            <Icon
              name="mail"
              size="huge" />
              <p>Email</p>
          </EmailShareButton>
        </div>
        <Grid columns="equal">
            <Grid.Column></Grid.Column>
            <Grid.Column width={14}>
              <Input size='small' ref={this.locationRef} defaultValue={this.props.location} className="share-text-input" />
              {this.state.textHasBeenCopied}
              <Button content='Copy' size={'small'} onClick={this.handleCopy} className="share-copy-button" />
            </Grid.Column>
            <Grid.Column></Grid.Column>
        </Grid>
      </Modal>
  }
}
