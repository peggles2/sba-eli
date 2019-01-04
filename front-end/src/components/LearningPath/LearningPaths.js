import React from 'react';
import LearningPathsList from './LearningPathsList';
import LearningPathAbout from './LearningPathAbout';
import MetaTags from '../SEO/MetaTags'
import { withRouter } from 'react-router-dom';
import { Container, Divider, Grid, Header } from 'semantic-ui-react';
import { connect } from "react-redux";

import { toggleModal } from '../../actions/aboutModalActions'

export class LearningPaths extends React.Component {
  handleModalClose = () => this.props.dispatch(toggleModal(false));

  render () {
    return(
      <div>
        <MetaTags metaTitle="SBA Learning Paths"
                metaDescription="Description for the Learning Path landing page"
                canonicalUrl="https://sba.gov/learning_paths"/>
        <Grid centered>
          <Grid.Row>
            <Header as='h2'>Explore All Paths</Header>
            <LearningPathAbout open={this.props.displayModal} handleClose={this.handleModalClose} />
          </Grid.Row>
          <Container>
            <Divider />
          </Container>
          <Grid.Row>
          </Grid.Row>
          <Grid.Row>
            <Container>
              <LearningPathsList />
            </Container>
          </Grid.Row>
        </Grid>
      </div>
    )
  }
}

export default connect((store) => {
  return {
    displayModal: store.aboutModal.show
  }
})(withRouter(LearningPaths));
