import React, { Component } from 'react';
import { Link, withRouter } from 'react-router-dom';
import {Button, Dropdown, Form, Menu} from 'semantic-ui-react';
import NavigationLearningPath from './NavigationLearningPath';
import RegistrationModal from '../RegistrationModal/RegistrationModal';
import { toggleRegister, toggleLogin } from '../../actions/navbarActions';

import { connect } from "react-redux";

export class Navbar extends Component {
  state = {}

  render() {
    return(
        <Menu className="navbar" fluid>
          <Menu.Item header href={`/`}>Dashboard</Menu.Item>
          <Dropdown text='Learning Paths' item>
            <Dropdown.Menu>
              <NavigationLearningPath />
            </Dropdown.Menu>
          </Dropdown>
          <Menu.Item>
            <Form id='navigation_site_search' method='GET' action='/search'>
              <Form.Group inline>
                <Form.Input icon='search' placeholder='Search' name='searchTerm' />
                <Form.Button type="submit">
                  Submit
                </Form.Button>
              </Form.Group>
            </Form>
          </Menu.Item>
          <Menu.Menu position='right'>
            <Menu.Item>
              <div>
                <Button onClick={() => this.props.dispatch(toggleRegister(true))}>Register</Button>
                <Button onClick={() => this.props.dispatch(toggleLogin(true))}>Login</Button>
                <RegistrationModal type={this.props.modalType} open={this.props.open}/>
              </div>
            </Menu.Item>
          </Menu.Menu>
        </Menu>
    )
  }
};

export default connect((store) => {
  return {
    modalType: store.navbar.modalType,
    open: store.navbar.open
  }
})(withRouter(Navbar));