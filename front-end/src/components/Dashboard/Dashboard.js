import React, {Component} from "react";
import LearningPaths from "../LearningPath/LearningPaths";
import { Divider } from "semantic-ui-react";
import DashboardHeader from "./DashboardHeader";
import DashboardSplash from "./DashboardSplash";
import DashboardCTA from "./DashboardCTA";
import MetaTags from "../SEO/MetaTags";

import "./Dashboard.scss";

export default class Dashboard extends Component {
  render() {
    return (
      <div className="dashboard">
        <MetaTags metaTitle="SBA Dashboard"
                  metaDescription="Description for the dashboard"
                  canonicalUrl="https://sba.gov/eli"/>
        <DashboardHeader />
        <DashboardSplash />
        <DashboardCTA />
        <Divider hidden />
        <LearningPaths />
      </div>
    );
  }
};
