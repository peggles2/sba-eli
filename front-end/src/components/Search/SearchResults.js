import React, {Component} from 'react'
import {Grid, Header} from "semantic-ui-react";
import {Link} from "react-router-dom";

export default class SearchResults extends Component {

  constructUri(id, metadataObject) {
    if (id === undefined
        && metadataObject !== undefined) {

      let uri = '/learning_paths/'
      if (metadataObject.learning_path_id !== undefined) {
        uri += metadataObject.learning_path_id
        if (metadataObject.learning_objective_id !== undefined) {
          uri += `/learning_objectives/` + metadataObject.learning_objective_id
          uri += `/learning_events/` + id
        } else {
          uri += `/learning_objectives/` + id
        }
      } else {
        uri += id
      }
      return uri
    }
    return ''
  }

  render() {
    return this.props.searchResults.map((sr, index) => (
        <Grid stackable className="search_result_item" id={'search_result_' + index} key={'search_result_' + index}>
          <Grid.Column width={5}>
            <div className="search_result_image">
              <Link to={this.constructUri(sr.id, sr.meta_data)}>
                <img className="search_result_image" src={sr.thumbnail} title={sr.name} alt={sr.name}/>
              </Link>
            </div>
          </Grid.Column>
          <Grid.Column width={11}>
            <div className="search_result_content">
              <Header as='h3' className="search_result_title">
                <Link to={this.constructUri(sr.id, sr.meta_data)}>
                  {sr.name}
                </Link>
              </Header>
              <div tabIndex="0" className="search_result_description">{sr.description}</div>
            </div>
          </Grid.Column>
        </Grid>
    ));
  }
}
