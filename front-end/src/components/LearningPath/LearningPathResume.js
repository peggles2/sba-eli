import React, { Component } from "react";
import { Button, Container, Divider, Grid, Header, Image, Item } from "semantic-ui-react";
import LearningPathProgress from "./LearningPathProgress";

export default class LearningPathResume extends Component {
  render () {
    const learningPathImage = `/Image_Placeholder.png`;
    const learningPathHeader = "Entreprenerurial Leadership";
    const learningPathDescription = "Maybe it means something more - something we can't yet understand."
    const complete = 2;
    const total = 5;

    return(
      <Container>
        <Grid>
          <Grid.Row>
            <Grid.Column>
              <Header as='h2'>Let's get back on your journey!</Header>
              <Divider />
            </Grid.Column>
          </Grid.Row>
          <Grid.Row className="learning-path-resume">
            <Grid.Column width={5} className="learning-path-resume-image">
              <Image size="large" src={learningPathImage} />
            </Grid.Column>
            <Grid.Column width={10} className="learning-path-resume-content">
              <Header as='h2'>{learningPathHeader}</Header>
              <p>{learningPathDescription}</p>
              <LearningPathProgress complete={complete} total={total} />
              <Divider />
              <Button primary style={{ float: "right" }}>Resume</Button>
            </Grid.Column>
          </Grid.Row>
        </Grid>
      </Container>
    )
  }
}
