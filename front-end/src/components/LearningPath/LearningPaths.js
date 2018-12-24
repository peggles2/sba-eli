import React from 'react';
import LearningPathsList from './LearningPathsList';
import LearningPathAbout from './LearningPathAbout';
import { withRouter } from 'react-router-dom';
import { Container, Header, Divider } from 'semantic-ui-react';
import { connect } from "react-redux";

import { toggleModal } from '../../actions/aboutModalActions'

export class LearningPaths extends React.Component {  
  handleModalClose = () => this.props.dispatch(toggleModal(false));

  render () {
    return(
      <div>
        <Container textAlign="center">
          <Header as='h1'>Learning Paths</Header>
          <LearningPathAbout open={this.props.displayModal} handleClose={this.handleModalClose} />
        </Container>
        <Divider hidden/>
        <Container>
          <LearningPathsList /> 
        </Container>
      </div>
    )
  }
}

export default connect((store) => {
  return {
    displayModal: store.aboutModal.show
  }
})(withRouter(LearningPaths));
