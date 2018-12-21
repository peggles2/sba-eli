import React from 'react'
import { Button, Grid, Icon, Modal } from 'semantic-ui-react'
import classnames from 'classnames'

import LearningPathAboutPage from './LearningPathAboutPage'
import './LearningPathAbout.scss'

class LearningPathAbout extends React.Component {
  state = {
    page: 1,
    modalOpen: false
  }
  
  turnPage = (dir) => this.setState({ page: this.state.page + dir })
  
  setPage = (page) => this.setState({ page: page })
  
  iconClasses = (page) => {
    return classnames({
      'learning-path-about-icon': page < 4,
      'learning-path-about-icon-selected': this.state.page === page,
      'learning-path-about-icon-unselected': this.state.page !== page,
    })
  }

  render() {    
    return (
      <Modal
        open={this.props.open}
        onClose={this.props.handleClose}
        closeOnDimmerClick={false}
      >
        <LearningPathAboutPage page={this.state.page} nextPage={() => this.turnPage(1)} handleClose={this.props.handleClose} />
        <Modal.Actions>
          <Grid verticalAlign='middle'>
            <Grid.Row>
              <Grid.Column width={4} textAlign="left">
                { this.state.page > 1 ? <Button onClick={() => this.turnPage(-1)}>Back</Button> : "" }
              </Grid.Column>
              
              <Grid.Column width={8} textAlign="center">
                <Icon name="circle" onClick={() => this.setPage(1)} className={ this.iconClasses(1) } />
                <Icon name="circle" onClick={() => this.setPage(2)} className={ this.iconClasses(2) } />
                <Icon name="circle" onClick={() => this.setPage(3)} className={ this.iconClasses(3) } />
                <Icon name="circle" onClick={() => this.setPage(4)} className={ this.iconClasses(4) } />
              </Grid.Column>
              
              <Grid.Column width={4} textAlign="right">
                { this.state.page < 4 ? <Button onClick={this.props.handleClose}>Skip</Button> : "" }
              </Grid.Column>
            </Grid.Row>
          </Grid>
        </Modal.Actions>
      </Modal>
    )
  }
}

export default LearningPathAbout;
