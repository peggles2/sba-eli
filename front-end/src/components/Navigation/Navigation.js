import React from "react";
import "../../App.css";
import { Grid } from "semantic-ui-react";
import { BrowserRouter as Router } from "react-router-dom";
import Navbar from "./Navbar";
import NavigationDisplay from "./NavigationDisplay";

const Navigation = () => {
  return (
    <Router>
      <Grid stackable width={16} className="sba">
        <Navbar />
        <NavigationDisplay />
      </Grid>
    </Router>

const NavigationDisplay = () => {
  return (
    <Switch>
      <Route exact path="/" component={Dashboard} />
      <Route exact path="/signup" component={SignUpForm} />
      <Route exact path="/login" component={LoginForm} />
      <Route exact path="/learning_paths" component={LearningPaths} />
      <Route exact path="/learning_paths/:id" component={LearningPath} />
      <Route
        exact
        path="/learning_paths/:course_id/learning_objectives/"
        component={LearningObjectives}
      />
      <Route
        exact
        path="/learning_paths/:course_id/learning_objectives/:id"
        component={LearningObjective}
      />
      <Route
        exact
        path="/learning_paths/:course_id/learning_objectives/:module_id/learning_events/:id"
        component={LearningEvent}
      />
      <Route
        exact
        path="/learning_paths/:course_id/learning_objectives/:module_id/learning_events"
        component={LearningEvents}
      />
      <Route
          exact
          path="/search"
          component={SearchPage}
      />
      <Route component={Error} />
    </Switch>
  );
};

export default Navigation;
