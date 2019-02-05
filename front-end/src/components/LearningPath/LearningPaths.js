import React from "react";
import LearningPathsList from "./LearningPathsList";
import LearningPathAbout from "./LearningPathAbout";
import LearningPathResume from "./LearningPathResume";
import MetaTags from "../SEO/MetaTags";
import { withRouter } from "react-router-dom";
import { Container, Divider, Grid, Header } from "semantic-ui-react";
import { connect } from "react-redux";

import { toggleModal } from "../../actions/aboutModalActions";
import { getLatestUserEnrollment } from "../../actions/learningPathActions";

export class LearningPaths extends React.Component {
  componentDidMount() {
    this.props.getLatestEnrollment();
  };

  componentDidUpdate(prevProps) {
    const prev = prevProps.isUserLoggedIn;
    const next = this.props.isUserLoggedIn;

    if(prev !== next) {
      this.props.getLatestEnrollment();
    };
  };

  learningPathResume = (isUserLoggedIn, hasUserStartedJourney) => {
    if(isUserLoggedIn && hasUserStartedJourney) {
      const id = this.props.latestUserEnrollment.course_id;
      return(
          <Grid.Row>
            <Grid.Column>
              <LearningPathResume learningPathId={id} />
            </Grid.Column>
          </Grid.Row>
      );
    };
  };

  render () {
    const isUserLoggedIn = this.props.isUserLoggedIn;
    const hasUserStartedJourney = this.props.hasUserStartedJourney;

    return (
      <div>
        <MetaTags
          metaTitle="SBA Journeys"
          metaDescription="Description for the Journey landing page"
          canonicalUrl="https://sba.gov/learning_paths"
        />
        <Grid>
          {this.learningPathResume(isUserLoggedIn, hasUserStartedJourney)}
          <Divider hidden />
          <Grid.Row>
            <Grid.Column>
              <Container>
                <Header as='h2'>{isUserLoggedIn && hasUserStartedJourney ? "Other Journeys you have Explored" : "Explore All Journeys"}</Header>
                <LearningPathAbout
                  open={this.props.displayModal}
                  handleClose={this.props.handleModalClose}
                />
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
    hasUserStartedJourney: store.learningPath.hasUserStartedJourney,
    latestUserEnrollment: store.learningPath.latestUserEnrollment,
  };
};

const mapDispatchToProps = dispatch => {
  return {
    handleModalClose: () => { dispatch(toggleModal(false)) },
    getLatestEnrollment: () => dispatch(getLatestUserEnrollment()),
  };
};
export default withRouter(connect(mapStateToProps, mapDispatchToProps)(LearningPaths));
