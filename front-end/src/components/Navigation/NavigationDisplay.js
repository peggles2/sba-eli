import React from 'react';
import {Route, Switch} from 'react-router-dom';
import Dashboard from '../Dashboard/Dashboard';
import Error from "../Error";
import LearningEvents from "../LearningEvent/LearningEvents";
import LearningObjective from "../LearningObjective/LearningObjective";
import LearningObjectives from "../LearningObjective/LearningObjectives";
import LearningPath from "../LearningPath/LearningPath";
import LearningPaths from "../LearningPath/LearningPaths";
import SignUpForm from "../SignUpForm/SignUpForm";
import SearchPage from "../Search/SearchPage";

const NavigationDisplay = () => {
  return (
      <Switch>
        <Route
            exact
            path="/"
            component={Dashboard} />
        <Route
            exact
            path="/learning_paths"
            component={LearningPaths} />
        <Route
            exact
            path="/learning_paths/:id"
            component={LearningPath} />
        <Route
            exact
            path="/learning_paths/:course_id/learning_objectives/"
            component={LearningObjectives} />
        <Route
            exact
            path="/learning_paths/:course_id/learning_objectives/:id"
            component={LearningObjective} />
        <Route
            exact
            path="/learning_paths/:id/learning_objectives/:topicId/learning_events/:eventId"
            component={LearningPath} />
        <Route
            exact
            path="/learning_paths/:course_id/learning_objectives/:module_id/learning_events"
            component={LearningEvents} />
        <Route
            exact
            path="/search"
            component={SearchPage} />

        <Route component={Error} />
      </Switch>
  );
}

export default NavigationDisplay;
