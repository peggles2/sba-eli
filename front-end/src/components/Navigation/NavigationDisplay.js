import React from 'react';
import {BrowserRouter as Router, Route, Switch} from 'react-router-dom';
import Dashboard from '../Dashboard/Dashboard';
import LearningPath from "../LearningPath/LearningPath";
import LearningPaths from "../LearningPath/LearningPaths";
import LearningObjective from "../LearningObjective/LearningObjective";
import LearningObjectives from "../LearningObjective/LearningObjectives";

const NavigationDisplay = () => {
  return (
    <Switch>
      <Route exact path="/" component={Dashboard}/>
      <Route exact path="/learning_paths" component={LearningPaths}/>
      <Route exact path="/learning_paths/:id" component={LearningPath} />
      <Route exact path="/learning_objectives/" component={LearningObjectives} />
      <Route exact path="/learning_objectives/:id" component={LearningObjective}/>
      <Route component={Error} />
    </Switch>
  )
}

export default NavigationDisplay;
