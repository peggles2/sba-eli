import React, { Component } from "react";
import axios from "axios";
import { Divider } from "semantic-ui-react";
import MultipleChoiceQuestion from "./MultipleChoiceQuestion";
import MultipleAnswerQuestion from "./MultipleAnswerQuestion";
import ShortAnswerQuestion from "./ShortAnswerQuestion";

//Placeholder for testing purposes to handle unaccounted learning event types
export default class LearningEventQuiz extends Component {
  
  constructor(props){
    super(props);

    this.state = {
      learningEvent: {
        description: "",
        results: []
      }
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
      return this.state.learningEvent.results.map((question, i) => {
        switch(question.question_type) {
          case 'multiple_choice_question':
            return <MultipleChoiceQuestion key={i} order={i+1} question={question} />
          case 'short_answer_question':
            return <ShortAnswerQuestion key={i} order={i+1} question={question} />
          case 'fill_in_multiple_blanks_question':
          return <MultipleAnswerQuestion key={i} order={i+1} question={question} />
          default:
            return <div key={i}><em>Question type not supported</em></div>
        }
      });
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
