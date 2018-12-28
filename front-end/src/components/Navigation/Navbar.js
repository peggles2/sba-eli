import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import {Button, Dropdown, Form, Menu} from 'semantic-ui-react';
import NavigationLearningPath from './NavigationLearningPath';
import SignUpModal from '../SignUpForm/SignUpModal';

class LoggedOutView extends Component {
  render() {
    return( 
      <div>
        <Button id="login" onClick={this.toggleLogin}>Login</Button>
        <SignUpModal/>
      </div>
    )
  }
}

export default class Navbar extends Component {
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
              <LoggedOutView />
            </Menu.Item>
          </Menu.Menu>
        </Menu>
    )
  }
};
