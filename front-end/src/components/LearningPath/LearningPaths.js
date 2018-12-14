import React from 'react';
import LearningPathsList from './LearningPathsList';
import MetaTags from '../SEO/MetaTags'
import { Container, Header, Divider } from 'semantic-ui-react';

class LearningPaths extends React.Component {
  state  = {}

  render () {
    return(
      <div>
        <MetaTags metaTitle="SBA Learning Paths"
                metaDescription="Description for the Learning Path landing page"
                canonicalUrl="https://sba.gov/learning_paths"/>
        <Container textAlign="center">
          <Header as='h1'>Learning Paths</Header>
        </Container>
        <Divider hidden/>
        <Container>
          <LearningPathsList /> 
        </Container>
      </div>
    )
  }
}

export default LearningPaths;
