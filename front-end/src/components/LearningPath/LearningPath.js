import React from "react";
import axios from "axios";
import { Header, Divider, Grid, Button, Icon } from "semantic-ui-react";

import TopicSideBar from "../TopicSideBar/TopicSidebar";
import TopicContentView from "../TopicContentView/TopicContentView";
import LearningEvent from "../LearningEvent/LearningEvent";
import LearningPathBreadCrumb from "./LearningPathBreadcrumb";
import MetaTags from "../SEO/MetaTags";

import "./LearningPath.scss";

export default class LearningPath extends React.Component {
  state = {
    learningPath: {},
    topicsList: []
  };

  componentDidMount() {
    this.initialFunctions();
  }

  componentWillReceiveProps() {
    this.initialFunctions();
  }

  initialFunctions() {
    const id = this.props.match.params.id;
    this.fetchLearningPath(id);
    this.fetchTopics(id);
    this.showLearningEvent();
  }

  showLearningEvent() {
    this.setState({
      isLearningEvent:
        this.props.match.params.topicId && this.props.match.params.eventId
    });
  }

  fetchLearningPath(id) {
    const url = process.env.REACT_APP_SERVICE_HOST + "/learning_paths/" + id;

    axios.get(url).then(res => {
      const learningPath = res.data;
      this.setState({ learningPath });
    });
  }

  fetchTopics(pathId) {
    const url = process.env.REACT_APP_SERVICE_HOST + `/learning_objectives/`;

    const topicParams = {
      course_id: pathId
    };

    axios
      .get(url, { params: topicParams })
      .then(res => {
        const topicsList = res.data;
        this.setState({ topicsList });
      })
      .catch(error => {
        console.log(error);
      });
  }

  renderRightColumnContent() {
    const isLearningEvent = this.state.isLearningEvent;

    if (isLearningEvent) {
      //This is to mimic react routing for the learning event. Learning event component
      //should be refactored to pass props
      const { eventId, topicId, id } = this.props.match.params;
      const eventMatch = {
        params: {
          id: eventId,
          module_id: topicId,
          course_id: id
        }
      };

      //send the topic Title for wrapper header purposes, break this into state?
      const topicTitle = this.state.topicsList.find(
        topic => topic.id.toString() === topicId.toString()
      );      
      return <LearningEvent match={eventMatch} topicTitle={topicTitle ? topicTitle.name : null} />;
    } else {
      return (
        <TopicContentView
          course_id={this.props.match.params.id}
          topicsList={this.state.topicsList}
        />
      );
    }
  }

  render() {
    const courseId = this.props.match.params.id;

    const sideBarProps = {
      course_id: courseId,
      topicsList: this.state.topicsList,
      module_id: this.props.match.params.topicId,
      event_id: this.props.match.params.eventId
    };

    const breadCrumbProps = this.props.match.params;

    return (
      <Grid centered>
        <MetaTags
          metaTitle={this.state.learningPath.name}
          metaDescription={this.state.learningPath.description}
          canonicalUrl={`https://sba.gov/learning_paths/${
            this.props.match.params.id
          }`}
        />
        <Grid.Row className={"path-breadcrumb-row"}>
          <Grid.Column mobile={15} tablet={15} computer={15}>
            <LearningPathBreadCrumb
              pathName={this.state.learningPath.name}
              {...breadCrumbProps}
            />
          </Grid.Column>
        </Grid.Row>
        <Grid.Row className={"path-header-row"}>
          <Grid.Column mobile={15} tablet={15} computer={15}>
            <Header as="h2" className={"path-header"}>
              {this.state.learningPath.name}
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
