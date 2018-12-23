import React, {Component} from 'react'
import {Form} from 'semantic-ui-react'

export default class MediaTypeFilters extends Component {

  render() {
    //TODO: should this be dynamic?
    const staticMediaFilters = [
      {key: 'video', text: 'Video'},
      {key: 'podcast', text: 'Podcast'},
      {key: 'infographic', text: 'Infographic'},
      {key: 'assessment', text: 'Assessment'},
      {key: 'discussion', text: 'Discussion'},
      {key: 'tools', text: 'Tools'}
    ]

    return staticMediaFilters.map(filter => {
          let selected = this.props.filters && this.props.filters.includes(filter.key)

          return (
              <Form.Checkbox name='mediaType'
                             value={filter.key}
                             key={filter.key}
                             id={'mediatype_filter_' + filter.key}
                             label={{children: filter.text}}
                             defaultChecked={selected}/>
          )
        }
    )
  }
}