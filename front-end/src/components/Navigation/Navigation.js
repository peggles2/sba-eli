import React from "react";
import "../../App.css";
import { Grid } from "semantic-ui-react";
import { BrowserRouter as Router } from "react-router-dom";
import Navbar from "./Navbar";
import NavigationDisplay from "./NavigationDisplay";

const Navigation = () => {
  return (
    <Router>
      <Grid stackable className="sba">
        <Navbar />
        <NavigationDisplay />
      </Grid>
    </Router>
  );
};

export default Navigation;
