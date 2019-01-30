import React from 'react';
import LearningPathsList from './LearningPathsList';
import LearningPathAbout from './LearningPathAbout';
import MetaTags from '../SEO/MetaTags'
import { withRouter } from 'react-router-dom';
import { Container, Divider, Grid, Header } from 'semantic-ui-react';
import { connect } from "react-redux";

import { toggleModal } from '../../actions/aboutModalActions'

export class LearningPaths extends React.Component {
  render () {
    const journeysHeader = "Explore All Journeys";

    return(
      <div>
        <MetaTags metaTitle="SBA Learning Paths"
                metaDescription="Description for the Learning Path landing page"
                canonicalUrl="https://sba.gov/learning_paths"/>
        <Grid>
          <Grid.Row>
            <Grid.Column>
              <Container>
                <Header as='h2'>{journeysHeader}</Header>
                <LearningPathAbout open={this.props.displayModal} handleClose={this.props.handleModalClose} />
                <Divider />
              </Container>
            </Grid.Column>
          </Grid.Row>
          <Grid.Row>
            <Grid.Column>
              <Container>
                <LearningPathsList />
              </Container>
            </Grid.Column>
          </Grid.Row>
        </Grid>
      </div>
    )
  };
};

const mapStateToProps = store => {
  return {
    displayModal: store.aboutModal.show,
  };
};

const mapDispatchToProps = dispatch => {
  return {
    handleModalClose: () => { dispatch(toggleModal(false)) },
  };
};
export default withRouter(connect(mapStateToProps, mapDispatchToProps)(LearningPaths));
