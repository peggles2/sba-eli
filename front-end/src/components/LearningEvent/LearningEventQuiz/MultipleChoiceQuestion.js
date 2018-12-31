import React, { Component } from "react";
import { Form, Radio, Divider } from "semantic-ui-react";

//Placeholder for testing purposes to handle unaccounted learning event types
export default class MultipleChoiceQuestion extends Component {

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
            <Form>
                { question.answers.map(a =>
                <Form.Field>
                    <Radio
                        label={a.text}
                        name='radioGroup'
                        value={a.id}
                        checked={this.state.value === a.id}
                        onChange={this.handleChange}
                    />
                </Form.Field>
                )}
            </Form>
            <Divider />
        </div>
        );
    }
}
