import React, { Component } from "react";
import axios from "axios";
import { Divider } from "semantic-ui-react";

//Placeholder for testing purposes to handle unaccounted learning event types
export default class LearningEventQuiz extends Component {
  
  constructor(props){
    super(props);

    this.state = {
      learningEvent: {}
    };
  }
  
  static getEventPath(course_id, content_id) {
    return (
      `/learning_paths/${course_id}` +
      `/quizzes/${content_id}`
    );
  }

  componentDidMount() {
    this.setLearningEvent();
  }

  componentWillReceiveProps(newProps) {
    //Added this to account for react routing not updating with different props
    if (this.props !== newProps) {
      this.props = newProps;
      this.setLearningEvent();
    }
  }

  setLearningEvent() {
    console.log(this.props.event)
    const course_id = this.props.courseId;
    const quiz_id = this.props.event.content_id;
    const url = process.env.REACT_APP_SERVICE_HOST + LearningEventQuiz.getEventPath(course_id, quiz_id);

    axios
      .get(url)
      .then(res => {
        const learningEvent = res.data;
        this.setState({ learningEvent });
      })
      .catch(error => {
        console.log(error);
      });
  }

  renderQuestions() {
    if(this.state.learningEvent && this.state.learningEvent.questions){
      this.state.learningEvent.questions.forEach((question, i) => {

      });
    }
  }

  render() {
    const description = this.state.learningEvent.description || "";
    return (
      <div className="learning-event-quiz">
        <span dangerouslySetInnerHTML={{
          __html: description
        }} />
        <Divider />
        {this.renderQuestions()}
      </div>
    );
  }
}
