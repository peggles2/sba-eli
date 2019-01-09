import React from 'react'
import { Card, Image } from "semantic-ui-react";
import LearningPathProgress from "./LearningPathProgress";

const LearningPathsItem = (props) => {
  return(
    <Card>
      <Image
        src={`/Image_Placeholder.png`}
        alt="learning path image placeholder"
      />
      <Card.Content>
        <Card.Header><a href={`/learning_paths/${props.id}`}>{props.name}</a></Card.Header>
        <Card.Meta>{props.course_code}</Card.Meta>
        <Card.Description>Maybe it means something more - something we can't yet understand.</Card.Description>
      </Card.Content>
      <Card.Content>
        <LearningPathProgress complete={4} total={5}/>
      </Card.Content>
    </Card>
  )
}

export default LearningPathsItem;
