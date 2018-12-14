import React from "react";
import "../../App.css";
import LearningPaths from "../LearningPath/LearningPaths";
import { Divider } from "semantic-ui-react";
import DashboardSplash from "./DashboardSplash";
import MetaTags from "../SEO/MetaTags";

const Dashboard = () => {
  return (
    <div>
      <MetaTags metaTitle="SBA Dashboard"
                metaDescription="Description for the dashboard"
                canonicalUrl=""/>
      <DashboardSplash />
      <Divider hidden />
      <LearningPaths />
    </div>
  );
};

export default Dashboard;
