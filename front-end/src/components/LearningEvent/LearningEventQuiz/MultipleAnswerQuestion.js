import React, { Component } from "react";
import { Input, Divider } from "semantic-ui-react";

//TODO: wil not work for anything other than display until we figure out how to do it with answers
export default class MultipleAnswerQuestion extends Component {

    state = {}
    handleChange = (e, { value }) => this.setState({ value })

    mapInputs(event){
        let q = {question_text: event.question_text, id: event.id, answers: event.answers.concat([])}
        let regex = new RegExp(q.answers.map(a=> '\\[' + a.blank_id + '\\]').join('|'))
        
        let splits = 
            q.question_text.split(regex).map(t => <p className="inline-form" dangerouslySetInnerHTML={{
                __html: t
            }} />)

        return splits.reduce((p,c) => [p, <div className="inline-form" style={{margin: "0 .5em"}}>
                <Input icon='pencil alternate' iconPosition='left' size="mini" onChange={this.handleChange}/>
            </div>, c])
    }

    render() {
        const question = this.props.question;
        let formatted = this.mapInputs(question)
        return (
        <div className="question multiple-choice">
            <p><strong>Question {this.props.order}</strong></p>
            <p>{formatted}</p>
            <Divider />
        </div>
        );
    }
}
