import React from "react";
import { List } from "semantic-ui-react";
import { Link } from "react-router-dom";

const LearningObjectivesItem = (props) => {
  const url = "/learning_paths/" + props.course_id + "/learning_objectives/" + props.item.id
  return(
    <List.Item><Link to={url}>{props.item.name}</Link></List.Item>
  )
}

export default LearningObjectivesItem;
