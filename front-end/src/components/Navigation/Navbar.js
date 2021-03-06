import React, { Component } from "react";
import { withRouter } from "react-router-dom";
import { Button, Dropdown, Form, Menu } from "semantic-ui-react";
import NavigationLearningPath from "./NavigationLearningPath";
import RegistrationModal from "../RegistrationModal/RegistrationModal";
import { toggleRegister, toggleLogin } from "../../actions/navbarActions";
import "./Navbar.scss";

import { connect } from "react-redux";
import { logoutUserAndReset } from '../../actions/registrationActions';

export class Navbar extends Component {
  state = {
    searchTerm: "",
    userButtonHover: false
  };

  handleSubmit = () => {
    this.props.history.push("/search?searchTerm=" + this.state.searchTerm);
  };

  searchTermChanged = e => {
    this.setState({ searchTerm: e.target.value });
  };

  loginButtons() {
    return (
      <Menu.Item className="registrationButtons">
        <div>
          <Button
            className={this.props.isUserLoggedIn ? "invisible" : "visible"}
            onClick={() => this.props.dispatch(toggleRegister(true))}
          >
            Register
          </Button>
          <Button
            className={this.props.isUserLoggedIn ? "invisible" : "visible"}
            onClick={() => this.props.dispatch(toggleLogin(true))}
          >
            Login
          </Button>
          <RegistrationModal
            type={this.props.modalType}
            open={this.props.open}
          />
        </div>
      </Menu.Item>
    );
  }

  logoutLink() {
    return (
      <div className="logoutLink">
        <Button className="logout-link-button"
          onClick={() =>
            this.props.dispatch(logoutUserAndReset(this.props.accessToken))
          }
        >
          Log out
        </Button>
      </div>
    );
  }

  greeting() {
    return (
      <Menu.Item className="userButtons">
        <div className="greeting">Hi, {this.props.userData.user.name}</div>
      </Menu.Item>
    );
  }

  userButtons() {
    return (
      <Menu.Item
        className="userButtons"
        onMouseEnter={() => {
          this.setState({ userButtonHover: true });
        }}
        onMouseLeave={() => {
          this.setState({ userButtonHover: false });
        }}
      >
        <div>
          {this.state.userButtonHover ? this.logoutLink() : this.greeting()}
        </div>
      </Menu.Item>
    );
  }

  render() {
    return (
      <Menu className="navbar" fluid>
        <Menu.Item header onClick={() => this.props.history.push("/")}>
          <img className="logo" src={`/Ascent_Logo_Stacked.png`} alt="Ascent" />
        </Menu.Item>
        <Dropdown text="Journeys" item id="navbar-learning-paths">
          <Dropdown.Menu className="navigation-learning-path-menu">
            <NavigationLearningPath />
          </Dropdown.Menu>
        </Dropdown>
        <Menu.Item className="search-bar">
          <Form
            id="navigation_site_search"
            onSubmit={this.handleSubmit.bind(this)}
          >
            <Form.Group inline>
              <Form.Input
                icon="search"
                placeholder="Search"
                name="searchTerm"
                className="search-input"
                value={this.state.searchTerm}
                onChange={this.searchTermChanged.bind(this)}
              />
              <Form.Button type="submit">Submit</Form.Button>
            </Form.Group>
          </Form>
        </Menu.Item>
        <Menu.Menu position="right">
          {this.props.isUserLoggedIn ? this.userButtons() : this.loginButtons()}
        </Menu.Menu>
      </Menu>
    );
  }
}

const mapStateToProps = store => {
  return {
    modalType: store.navbar.modalType,
    open: store.navbar.open,
    isUserLoggedIn: store.login.isUserLoggedIn,
    userData: store.login.userData,
    accessToken: store.login.userData.access_token
  };
};

export default withRouter(connect(mapStateToProps)(Navbar));
