import React, { Component } from "react";
import { Button, Divider, Icon, Header } from "semantic-ui-react";
import { connect } from "react-redux";
import { withRouter } from "react-router-dom";
import {
  getLearningPathQuizzes,
  clearQuizSubmission,
  getQuiz,
  submitQuiz
} from "../../../actions/learningPathActions";
import { completeLearningEvent } from "../../../actions/learningEventActions";
import {
  MultipleChoiceQuestion,
  MultipleAnswerQuestion,
  ShortAnswerQuestion
} from "./LearningEventQuestions";

//Placeholder for testing purposes to handle unaccounted learning event types
export class LearningEventQuiz extends Component {
  constructor(props) {
    super(props);

    this.state = {
      answers: {},
      results: null,
      viewResultsDisabled: true
    };

    this.beginQuiz = this.beginQuiz.bind(this);
    this.recordAnswer = this.recordAnswer.bind(this);
    this.viewResults = this.viewResults.bind(this);
  }

  componentDidMount() {
    this.props.dispatch(getLearningPathQuizzes(this.props.courseId));
    if (this.props.event) {
      this.beginQuiz();
    }
  }

  componentDidUpdate(prevProps) {
    if (
      this.props.event &&
      this.props.event.content_id !== prevProps.event.content_id
    ) {
      this.beginQuiz();
    } else if (this.props.results && !this.state.results) {
      this.setState({ results: this.props.results });
    }
  }

  completeEvent() {
    const { isUserLoggedIn, event } = this.props;
    if (isUserLoggedIn && !event.completion_requirement.completed) {
      const { id: path_id, topicId: objective_id } = this.props.match.params;

      this.props.dispatch(
        completeLearningEvent(path_id, objective_id, event.id)
      );
    }
  }

  recordAnswer(id, answer) {
    let answers = this.state.answers;
    answers[id] = answer;
    this.setState({ answers });
    this.checkToEnableViewResults();
  }

  checkToEnableViewResults() {
    const answers = Object.keys(this.state.answers);
    const { quiz } = this.props;

    if (answers && quiz.questions && answers.length === quiz.questions.length) {
      this.setState({ viewResultsDisabled: false });
    }
  }

  beginQuiz() {
    this.setState({ results: null, answers: {}, viewResultsDisabled: true });
    this.props.dispatch(clearQuizSubmission());
    this.props.dispatch(
      getQuiz(this.props.courseId, this.props.event.content_id)
    );
  }

  viewResults() {
    let answers = Object.keys(this.state.answers).map(k => {
      return {
        id: k,
        answer: this.state.answers[k]
      };
    });

    let submission = {
      submission_id: this.props.quiz.submission_id,
      attempt: this.props.quiz.attempt,
      validation_token: this.props.quiz.validation_token,
      quiz_questions: answers
    };

    this.props.dispatch(
      submitQuiz(this.props.courseId, this.props.event.content_id, submission)
    );
    this.completeEvent();
  }

  renderQuestions() {
    return this.props.quiz.questions.map((question, i) => {
      switch (question.question_type) {
        case "multiple_choice_question":
          return (
            <MultipleChoiceQuestion
              key={i}
              order={i + 1}
              question={question}
              onSelected={this.recordAnswer}
            />
          );
        case "short_answer_question":
          return (
            <ShortAnswerQuestion key={i} order={i + 1} question={question} />
          );
        case "fill_in_multiple_blanks_question":
          return (
            <MultipleAnswerQuestion key={i} order={i + 1} question={question} />
          );
        default:
          return (
            <div key={i}>
              <em>Question type not supported</em>
            </div>
          );
      }
    });
  }

  // this will be used if we choose to use quiz functionality in addition to assessments later
  renderStart() {
    return (
      this.props.submissionsLoading === false &&
      !this.props.submissions.length && (
        <Button icon labelPosition="right" primary onClick={this.beginQuiz}>
          Begin Assesment
          <Icon name="pencil alternate" />
        </Button>
      )
    );
  }

  renderResults() {
    const { results } = this.state;

    return results && results.category ? (
      <div>
        <Header as="h2">{results.category.name}</Header>
        <div>{results.category.description}</div>
        <div style={{ textAlign: "right" }}>
          <Button className="gold" onClick={this.beginQuiz}>
            Retake Assessment
          </Button>
        </div>
      </div>
    ) : (
      <span>
        <em>Your submission does not match any results</em>
      </span>
    );
  }

  render() {
    const description =
      this.props.event && this.props.event.eventContent
        ? this.props.event.eventContent.description
        : "";
    return (
      <div className="learning-event-quiz">
        <span
          dangerouslySetInnerHTML={{
            __html: description
          }}
        />
        <Divider />
        {this.state.results ? (
          this.renderResults()
        ) : this.props.quiz && this.props.quiz.questions ? (
          this.renderQuestions()
        ) : (
          <span />
        )}
        {this.props.quiz.questions && !this.props.results && (
          <div style={{ textAlign: "right" }}>
            <Button
              className="gold"
              onClick={this.viewResults}
              disabled={this.state.viewResultsDisabled}
            >
              View Results
            </Button>
          </div>
        )}
      </div>
    );
  }
}

const mapStateToProps = store => {
  return {
    quizzes: store.learningPath.quizzes,
    quiz: store.learningPath.quiz,
    submissions: store.learningPath.quizSubmissions,
    submissionsLoading: store.learningPath.quizSubmissionsLoading,
    results: store.learningPath.submitQuiz,
    isUserLoggedIn: store.login.isUserLoggedIn
  };
};

export default withRouter(connect(mapStateToProps)(LearningEventQuiz));
