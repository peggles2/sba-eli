import React from "react";
import { Header, Divider, Grid, Button, Icon } from "semantic-ui-react";
import { connect } from "react-redux";
import { withRouter } from "react-router-dom";

import TopicSideBar from "../TopicSideBar/TopicSidebar";
import TopicContentView from "../TopicContentView/TopicContentView";
import LearningEvent from "../LearningEvent/LearningEvent";
import LearningPathBreadCrumb from "./LearningPathBreadcrumb";
import MetaTags from "../SEO/MetaTags";

import { getPathWithTopics } from "../../actions/learningPathActions";

import "./LearningPath.scss";

export class LearningPath extends React.Component {
  componentDidMount() {
    this.initialFunctions();
  }

  initialFunctions() {
    const id = this.props.match.params.id;
    this.props.dispatch(getPathWithTopics(id));
  }

  componentDidUpdate(prevProps) {
    if (this.props.isUserLoggedIn !== prevProps.isUserLoggedIn) {
      const id = this.props.match.params.id;
      this.props.dispatch(getPathWithTopics(id));
    }
    
    if(this.props.match.params.topicId !== prevProps.match.params.topicId && this.props.match.params.eventId !== prevProps.match.params.eventId) {
      this.initialFunctions();
    }
  }

  renderRightColumnContent() {
    const isLearningEvent =
      this.props.match.params.topicId && this.props.match.params.eventId;
    const { topicId, id } = this.props.match.params;

    if (isLearningEvent) {
      //send the topic Title for wrapper header purposes, break this into state?
      const topicTitle = this.props.topicsList.find(
        topic => topic && topic.id ? topic.id.toString() === topicId.toString() : false
      );
      return <LearningEvent topicTitle={topicTitle ? topicTitle.name : null} />;
    } else {
      return (
        <TopicContentView course_id={id} topicsList={this.props.topicsList} />
      );
    }
  }

  render() {
    const courseId = this.props.match.params.id;

    const sideBarProps = {
      course_id: courseId,
      topicsList: this.props.topicsList,
      module_id: this.props.match.params.topicId,
      event_id: this.props.match.params.eventId
    };

    const breadCrumbProps = this.props.match.params;

    return (
      <Grid centered>
        <MetaTags
          metaTitle={this.props.learningPath.name}
          metaDescription={this.props.learningPath.description}
          canonicalUrl={`https://sba.gov/learning_paths/${
            this.props.match.params.id
          }`}
        />
        <Grid.Row className={"path-breadcrumb-row"}>
          <Grid.Column mobile={15} tablet={15} computer={15}>
            <LearningPathBreadCrumb
              pathName={this.props.learningPath.name}
              {...breadCrumbProps}
            />
          </Grid.Column>
        </Grid.Row>
        <Grid.Row className={"path-header-row"}>
          <Grid.Column mobile={15} tablet={15} computer={15}>
            <Header as="h2" className={"path-header"}>
              {this.props.learningPath.name}
              <Button className={"path-header-share mobile hidden"}>
                Share &nbsp; <Icon name={"share"} />
              </Button>
            </Header>
          </Grid.Column>
        </Grid.Row>
        <Divider />
        <Grid.Row>
          <Grid.Column
            className={"mobile hidden"}
            tablet={5}
            computer={5}
            largeScreen={3}
            widescreen={3}
          >
            <TopicSideBar {...sideBarProps} />
          </Grid.Column>
          <Grid.Column
            mobile={15}
            tablet={11}
            computer={11}
            largeScreen={11}
            widescreen={11}
          >
            {this.renderRightColumnContent()}
          </Grid.Column>
        </Grid.Row>
      </Grid>
    );
  }
}

const mapStateToProps = store => {
  return {
    learningPath: store.learningPath.learningPath,
    topicsList: store.learningPath.topicsList,
    isUserLoggedIn: store.login.isUserLoggedIn
  };
};

export default withRouter(connect(mapStateToProps)(LearningPath));