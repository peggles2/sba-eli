import React, {Component} from "react";
import LearningPaths from "../LearningPath/LearningPaths";
import { Divider } from "semantic-ui-react";
import DashboardHeader from "./DashboardHeader";
import DashboardSplash from "./DashboardSplash";
import DashboardCTA from "./DashboardCTA";
import MetaTags from "../SEO/MetaTags";

import "./Dashboard.scss";

export default class Dashboard extends Component {
  // will need to connect isLoggedIn to redux
  state = { isLoggedIn: true}

  dashboardHeader = (isLoggedIn) => {
    if(isLoggedIn) {
      return <DashboardHeader />;
    }
  }

  splash = (isLoggedIn) => {
    if(isLoggedIn) {
      return <DashboardCTA />;
    } else {
      return <DashboardSplash />;
    }
  }

  render() {
    const isLoggedIn = this.state.isLoggedIn;

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
