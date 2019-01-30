import React from 'react';
import LearningPathsList from './LearningPathsList';
import LearningPathAbout from './LearningPathAbout';
import LearningPathResume from './LearningPathResume';
import MetaTags from '../SEO/MetaTags'
import { withRouter } from 'react-router-dom';
import { Container, Divider, Grid, Header } from 'semantic-ui-react';
import { connect } from "react-redux";

import { toggleModal } from '../../actions/aboutModalActions'

export class LearningPaths extends React.Component {
  learningPathResume = (isUserLoggedIn) => {
    if(isUserLoggedIn) {
      return(
          <Grid.Row>
            <Grid.Column>
              <LearningPathResume />
            </Grid.Column>
          </Grid.Row>
      );
    };
  };

  render () {
    const isUserLoggedIn = this.props.isUserLoggedIn;

    return(
      <div>
        <MetaTags metaTitle="SBA Learning Paths"
                metaDescription="Description for the Learning Path landing page"
                canonicalUrl="https://sba.gov/learning_paths"/>
        <Grid>
          {this.learningPathResume(isUserLoggedIn)}
          <Divider hidden />
          <Grid.Row>
            <Grid.Column>
              <Container>
                <Header as='h2'>{isUserLoggedIn ? "Other Journeys you have Explored" : "Explore All Journeys"}</Header>
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
    isUserLoggedIn: store.login.isUserLoggedIn,
  };
};

const mapDispatchToProps = dispatch => {
  return {
    handleModalClose: () => { dispatch(toggleModal(false)) },
  };
};
export default withRouter(connect(mapStateToProps, mapDispatchToProps)(LearningPaths));
