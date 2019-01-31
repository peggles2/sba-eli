import React from "react";
import LearningPathsList from "./LearningPathsList";
import LearningPathAbout from "./LearningPathAbout";
import MetaTags from "../SEO/MetaTags";
import { withRouter } from "react-router-dom";
import { Container, Divider, Grid, Header } from "semantic-ui-react";
import { connect } from "react-redux";

import { toggleModal } from "../../actions/aboutModalActions";

export class LearningPaths extends React.Component {
  handleModalClose = () => this.props.dispatch(toggleModal(false));

  render() {
    return (
      <div>
        <MetaTags
          metaTitle="SBA Journeys"
          metaDescription="Description for the Journey landing page"
          canonicalUrl="https://sba.gov/learning_paths"
        />
        <Grid>
          <Grid.Row>
            <Grid.Column>
              <Container>
                <Header as="h2">Explore All Journeys</Header>
                <LearningPathAbout
                  open={this.props.displayModal}
                  handleClose={this.handleModalClose}
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
    );
  }
}

const mapStateToProps = store => {
  return {
    displayModal: store.aboutModal.show
  };
};

export default withRouter(connect(mapStateToProps)(LearningPaths));
