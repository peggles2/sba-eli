import React from "react";
import "../../App.css";
import { Grid } from "semantic-ui-react";
import { Switch, Route, BrowserRouter as Router } from "react-router-dom";
import Navbar from "./Navbar";
import NavigationDisplay from "./NavigationDisplay";
import Dashboard from "../Dashboard/Dashboard";
import SignUpForm from "../SignUpForm/SignUpForm";
import LoginForm from "../LoginForm/LoginForm";
import LearningPaths from "../LearningPath/LearningPaths";
import LearningPath from "../LearningPath/LearningPath";
import LearningObjectives from "../LearningObjective/LearningObjectives";
import LearningObjective from "../LearningObjective/LearningObjective";
import LearningEvents from "../LearningEvent/LearningEvents";
import LearningEvent from "../LearningEvent/LearningEvent";
import SearchPage from "../Search/SearchPage";

const Navigation = () => {
  return (
    <Router>
      <Grid stackable width={16} className="sba">
        <Navbar />
        <NavigationDisplay />
      </Grid>
    </Router>
  )
};

export default Navigation;
