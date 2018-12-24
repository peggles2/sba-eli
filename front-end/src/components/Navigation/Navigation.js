import React from "react";
import "../../App.css";
import { Grid } from "semantic-ui-react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Dashboard from "../Dashboard/Dashboard";
import LearningPath from "../LearningPath/LearningPath";
import LearningPaths from "../LearningPath/LearningPaths";
import LearningObjective from "../LearningObjective/LearningObjective";
import LearningObjectives from "../LearningObjective/LearningObjectives";
import Navbar from "./Navbar";
import LearningEvent from "../LearningEvent/LearningEvent";
import LearningEvents from "../LearningEvent/LearningEvents";
import SearchPage from "../Search/SearchPage";
import SignUpForm from "../SignUpForm/SignUpForm";
import Error from "../Error";

const Navigation = () => {
  return (
    <div>
      <Router>
        <div>
          <Navbar />
          <Grid>
            <Grid.Row>
              <Grid.Column mobile={16} tablet={8} computer={16}>
                <NavigationDisplay />
              </Grid.Column>
            </Grid.Row>
          </Grid>
        </div>
      </Router>
    </div>
  );
};

const NavigationDisplay = () => {
  return (
    <Switch>
      <Route exact path="/" component={Dashboard} />
      <Route exact path="/signup" component={SignUpForm} />
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
        path="/learning_paths/:id/learning_objectives/:topicId/learning_events/:eventId"
        component={LearningPath}
      />
      <Route
        exact
        path="/learning_paths/:course_id/learning_objectives/:module_id/learning_events"
        component={LearningEvents}
      />
      <Route exact path="/search" component={SearchPage} />

      <Route component={Error} />
    </Switch>
  );
};

export default Navigation;
