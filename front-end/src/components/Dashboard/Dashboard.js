import React, {Component} from "react";
import LearningPaths from "../LearningPath/LearningPaths";
import { Divider } from "semantic-ui-react";
import DashboardHeader from "./DashboardHeader";
import DashboardSplash from "./DashboardSplash";
import DashboardCTA from "./DashboardCTA";
import MetaTags from "../SEO/MetaTags";

import "./Dashboard.scss";

export default class Dashboard extends Component {

  dashboardHeader = (isLoggedIn) => {
    if(isLoggedIn) {
      return <DashboardHeader />;
    }
  }

  splash = (isLoggedIn) => {
    if(isLoggedIn) {
      return <DashboardCTA />;
    } 
    return <DashboardSplash />;
  }

  render() {
    const isLoggedIn = this.props.isLoggedIn;

    return (
      <div className="dashboard">
        <MetaTags metaTitle="SBA Dashboard"
                  metaDescription="Description for the dashboard"
                  canonicalUrl="https://sba.gov/eli"/>
        { this.dashboardHeader(isLoggedIn) }
        { this.splash(isLoggedIn) }
        <Divider hidden />
        <LearningPaths />
      </div>
    );
  }
};

