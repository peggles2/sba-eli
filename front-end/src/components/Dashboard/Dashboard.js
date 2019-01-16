import React, {Component} from "react";
import LearningPaths from "../LearningPath/LearningPaths";
import { Divider } from "semantic-ui-react";
import DashboardHeader from "./DashboardHeader";
import DashboardSplash from "./DashboardSplash";
import DashboardCTA from "./DashboardCTA";
import MetaTags from "../SEO/MetaTags";

import { connect } from "react-redux";

import "./Dashboard.scss";

export class Dashboard extends Component {

  dashboardHeader = (isUserLoggedIn) => {
    if(isUserLoggedIn) {
      return <DashboardHeader />;
    }
  }

  splash = (isUserLoggedIn) => {
    if(isUserLoggedIn) {
      return <DashboardCTA />;
    } 
    return <DashboardSplash />;
  }

  render() {
    const isUserLoggedIn = this.props.isUserLoggedIn;

    return (
      <div className="dashboard">
        <MetaTags metaTitle="SBA Dashboard"
                  metaDescription="Description for the dashboard"
                  canonicalUrl="https://sba.gov/eli"/>
        { this.dashboardHeader(isUserLoggedIn) }
        { this.splash(isUserLoggedIn) }
        <Divider hidden />
        <LearningPaths />
      </div>
    );
  }
};

const mapStateToProps = (store) => {
  return { isUserLoggedIn: store.login.isUserLoggedIn }
};

export default connect(mapStateToProps)(Dashboard);
