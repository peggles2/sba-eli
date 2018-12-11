import React from 'react';
import LearningPathsList from './LearningPathsList';
import LearningPathAbout from './LearningPathAbout';
import { withRouter } from 'react-router-dom';
import { Container, Header, Divider } from 'semantic-ui-react';

class LearningPaths extends React.Component {
  state  = {
    displayModal: false
  }
  
  componentDidMount() {
    if(this.props.location.pathname === "/learning_paths" && this.props.location.state && this.props.location.state.showModal) {
      this.setState({displayModal: true})
    } else {
      this.setState({displayModal: false})
    }
  }
  
  componentDidUpdate(prevProp, prevState) {
    if(prevProp.location.pathname !== this.props.location.pathname) {
      if(this.props.location.pathname === "/learning_paths" && this.props.location.state && this.props.location.state.showModal) {
        this.setState({displayModal: true})
      } else {
        this.setState({displayModal: false})
      }
    }
  }
  
  handleModalClose = () => this.setState({displayModal: false});

  render () {
    return(
      <div>
        <LearningPathAbout open={this.state.displayModal} handleClose={this.handleModalClose} />
        <Container textAlign="center">
          <Header as='h1'>Learning Paths</Header>
        </Container>
        <Divider hidden/>
        <Container>
          <LearningPathsList /> 
        </Container>
      </div>
    )
  }
}

export default withRouter(LearningPaths);
