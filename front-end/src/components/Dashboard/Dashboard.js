import React from "react";
import "../../App.css";
import LearningPaths from "../LearningPath/LearningPaths";
import { Divider } from "semantic-ui-react";
import DashboardSplash from "./DashboardSplash";

const Dashboard = () => {
  return (
    <div>
      <DashboardSplash />
      <Divider hidden />
      <LearningPaths />
    </div>
  );
};

export default Dashboard;
