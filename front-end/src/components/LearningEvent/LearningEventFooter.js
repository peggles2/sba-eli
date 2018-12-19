import React, { Component } from "react";
import { Link } from "react-router-dom";
import { Icon, Button } from "semantic-ui-react";

export default class LearningEventFooter extends Component {
  createEventPath(course_id, module_id, event_id){
      return (
          `/learning_paths/${course_id}` +
          `/learning_objectives/${module_id}` +
          `/learning_events/${event_id}`)
  }
  
  parseNextPrev(modules, event){
      let paging = {next: null, prev:  null}
      
      if(event && event.position && modules){
          const pos = event.position-1 //To account for zero based array indeces
          paging.next = modules[pos+1] ? this.createEventPath(this.props.courseId, event.module_id, modules[pos+1].id) : null
          paging.prev = modules[pos-1] ? this.createEventPath(this.props.courseId, event.module_id, modules[pos-1].id) : null
      }
      return paging
  }
  
  render() {
    const np = this.parseNextPrev(this.props.module, this.props.event)

    return (
        <div className="page-navigation-buttons" >
            {
                np.prev && 
                <Link to={np.prev}>
                    <Button icon labelPosition='left'>
                      <Icon name='left arrow' />
                      Previous
                    </Button>
                </Link>
            }
            {
                np.next &&
                <Link to={np.next}>
                    <Button icon labelPosition='right' primary>
                      Next
                      <Icon name='right arrow' />
                    </Button>
                </Link>
            }

        </div>
    );
  }
}
