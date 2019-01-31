import React, {Component} from "react";
import LearningPaths from "../LearningPath/LearningPaths";
import { Divider } from "semantic-ui-react";
import DashboardHeader from "./DashboardHeader";
import DashboardSplash from "./DashboardSplash";
import DashboardCTA from "./DashboardCTA";
import MetaTags from "../SEO/MetaTags";

import { connect } from "react-redux";
import { getLatestUserEnrollment } from "../../actions/learningPathActions";

import "./Dashboard.scss";

export class Dashboard extends Component {

  componentDidMount() {
    this.props.getLatestEnrollment()
  }

  dashboardHeader = (isUserLoggedIn) => {
    if(isUserLoggedIn) {
      return <DashboardHeader />;
    }
  }

  splash = (isUserLoggedIn, hasUserStartedJourney) => {
    if(isUserLoggedIn && !hasUserStartedJourney) {
      return <DashboardCTA />;
    } else if(!isUserLoggedIn) {
      return <DashboardSplash />;
    }
  }

  render() {
    const isUserLoggedIn = this.props.isUserLoggedIn;
    const hasUserStartedJourney = this.props.hasUserStartedJourney;

    return (
      <div className="dashboard">
        <MetaTags metaTitle="SBA Dashboard"
                  metaDescription="Description for the dashboard"
                  canonicalUrl="https://sba.gov/eli"/>
        { this.dashboardHeader(isUserLoggedIn) }
        { this.splash(isUserLoggedIn, hasUserStartedJourney) }
        <Divider hidden />
        <LearningPaths />
      </div>
    );
  }
};

const mapStateToProps = store => {
  return {
    isUserLoggedIn: store.login.isUserLoggedIn,
    hasUserStartedJourney: store.learningPath.hasUserStartedJourney,
  };
};

const mapDispatchToProps = dispatch => {
  return {
    getLatestEnrollment: () => dispatch(getLatestUserEnrollment()),
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(Dashboard);
