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
    this.state = {
      modalOpen: false,
      copyButtonText: 'Copy'
    }
  }

  handleOpen = () => this.setState({ modalOpen: true })

  handleClose = () => {
    this.setState({ modalOpen: false })
    this.setState({ copyButtonText: 'Copy' })
  }

  handleCopy = (e) =>  {
    var locationValue = this.locationRef.current;
    locationValue.select();
    document.execCommand("copy");
    this.setState({ copyButtonText: 'Copied!' })
  }

  render() {
    return <Modal trigger={<Button onClick={this.handleOpen} className="share-modal-button mobile hidden">Share &nbsp; <Icon name={"share"} /></Button>}
                  id="shareModal"
                  open={this.state.modalOpen}
                  onClose={this.handleClose}
                  closeOnDimmerClick={false}
                  size={'tiny'} >
      <Modal.Content>
        <Grid>
          <Grid.Row stretched columns={16}>
            <Grid.Column width={14}>
              <h2>Share this {this.props.contentType}</h2>
            </Grid.Column>
            <Grid.Column width={2}>
              <Button className='eli-modal-close-button' onClick={this.handleClose} icon><Icon link name='close' size='large'/></Button>
            </Grid.Column>
          </Grid.Row>
        </Grid>
        <hr/>
        <p>
          {this.props.description}
        </p>
        <Grid>
          <Grid.Row columns={16} className="share-method-group">
            <Grid.Column width={4} className="first-share-column share-method-column">
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
            </Grid.Column>
            <Grid.Column width={4}>
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
            </Grid.Column>
            <Grid.Column width={4}>
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
            </Grid.Column>
            <Grid.Column width={4}>
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
            </Grid.Column>
          </Grid.Row>
        </Grid>
          <Grid columns="equal">
              <Grid.Column></Grid.Column>
              <Grid.Column width={14}>
                <Input size='small' ref={this.locationRef} defaultValue={this.props.location} className="share-text-input" />
                {this.state.textHasBeenCopied}
                <Button content={this.state.copyButtonText} size={'small'} onClick={this.handleCopy} className="share-copy-button" />
              </Grid.Column>
              <Grid.Column></Grid.Column>
          </Grid>
        </Modal.Content>
      </Modal>
  }
}
