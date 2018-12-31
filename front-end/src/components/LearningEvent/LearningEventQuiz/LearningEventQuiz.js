import React, { Component } from "react";
import { Button, Divider, Icon } from "semantic-ui-react";
import { connect } from "react-redux";
import { withRouter } from 'react-router-dom';
import { getLearningPathQuizzes, getQuiz } from "../../../actions/learningPathActions";
import { MultipleChoiceQuestion, MultipleAnswerQuestion, ShortAnswerQuestion } from "./LearningEventQuestions";

//Placeholder for testing purposes to handle unaccounted learning event types
export class LearningEventQuiz extends Component {
  
  constructor(props){
    super(props);

    this.state = {
      answers: {
      }
    };

    this.beginQuiz = this.beginQuiz.bind(this)
    this.recordAnswer = this.recordAnswer.bind(this)
  }

  componentDidMount() {
    this.props.dispatch(getLearningPathQuizzes(this.props.courseId))
  }

  componentWillReceiveProps(newProps) {

  }

  recordAnswer(id, answer){
    let answers = this.state.answers
    answers[id] = answer
    this.setState({answers}, () => console.log(answers))
  }

  beginQuiz(){
    this.props.dispatch(getQuiz(this.props.courseId, this.props.event.content_id));
  }

  renderQuestions() {
      if(this.props.quiz && this.props.quiz.questions){
        return this.props.quiz.questions.map((question, i) => {
          switch(question.question_type) {
            case 'multiple_choice_question':
              return <MultipleChoiceQuestion key={i} order={i+1} question={question} onSelected={this.recordAnswer} />
            case 'short_answer_question':
              return <ShortAnswerQuestion key={i} order={i+1} question={question} />
            case 'fill_in_multiple_blanks_question':
              return <MultipleAnswerQuestion key={i} order={i+1} question={question} />
            default:
              return <div key={i}><em>Question type not supported</em></div>
          }
        });
      }
      else {
        return <Button icon labelPosition="right" primary onClick={this.beginQuiz} >
                  Begin Assesment
                  <Icon name="pencil alternate" />
              </Button>
      }
  }

  render() {
    const description = this.props.event && this.props.event.eventContent ? this.props.event.eventContent.description : "";
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

export default connect((store) => {
  return {
    quizzes: store.learningPath.quizzes,
    quiz: store.learningPath.quiz
  }
})(withRouter(LearningEventQuiz));