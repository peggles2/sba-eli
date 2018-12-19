import React, { Component } from 'react';
import { Form } from 'semantic-ui-react'

export default class SubjectFilters extends Component {
  render () {
    const subjectFilters = [
      {key: 'finance', text: 'Finance'},
      {key: 'communications', text: 'Communications'},
      {key: 'management', text: 'Management'},
      {key: 'marketing', text: 'Marketing'},
      {key: 'sales', text: 'Sales'},
      {key: 'strategy', text: 'Strategy'},
    ]

    return subjectFilters.map(filter => {
      let selected = this.props.filters && this.props.filters.includes(filter.key)

      return (
        <Form.Checkbox name='subject'
                      value={filter.key}
                      key={filter.key}
                      id={'subject_filter_' +  filter.key}
                      label={{children: filter.text}}
                       defaultChecked={selected}/>
      )
    })
  }
}
