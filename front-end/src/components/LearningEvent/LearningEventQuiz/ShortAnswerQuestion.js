import React, { Component } from "react";
import { Input, Divider } from "semantic-ui-react";

//Placeholder for testing purposes to handle unaccounted learning event types
export default class ShortAnswerQuestion extends Component {

    state = {}
    handleChange = (e, { value }) => this.setState({ value })

    render() {
        const question = this.props.question;
        return (
        <div className="question multiple-choice">
            <p><strong>Question {this.props.order}</strong></p>
            <p dangerouslySetInnerHTML={{
            __html: question.question_text
            }} />
            <Input icon='pencil alternate' iconPosition='left' placeholder='Enter answer here' onChange={this.handleChange}/>
            <Divider />
        </div>
        );
    }
}
