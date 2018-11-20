import React from 'react';
import '../../App.css';
import { Grid } from 'semantic-ui-react';
import {BrowserRouter as Router, Route, Switch} from 'react-router-dom';
import Dashboard from '../Dashboard/Dashboard';
import LearningPath from "../LearningPath/LearningPath";
import LearningPaths from "../LearningPath/LearningPaths";
import LearningObjective from "../LearningObjective/LearningObjective";
import LearningObjectives from "../LearningObjective/LearningObjectives";
import NavigationMenu from "./NavigationMenu";

const Navigation = () => {
  return (
      <Router>
        <div>
          <Grid>
            <Grid.Row>
              <Grid.Column width={2}>
                <NavigationMenu/>
              </Grid.Column>
              <Grid.Column width={13}>
                  <NavigationDisplay />
              </Grid.Column>
            </Grid.Row>
          </Grid>
        </div>
      </Router>
  );
}

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

export default Navigation;
