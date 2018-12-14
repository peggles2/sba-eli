import React, { Component } from "react";
import Navigation from "./components/Navigation/Navigation";
import MetaTags from "./components/SEO/MetaTags";

class App extends Component {
  render() {
    return (
    <div className="application">
      <MetaTags />
      <Navigation />
    </div>
    );
  }
}

export default App;
