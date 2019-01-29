import React from "react";
import {
  Button,
  Container,
  Header,
  Icon,
  Image,
  Modal
} from "semantic-ui-react";

const LearningPathAboutPage = props => {
  let placeholderText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras a elit non massa blandit egestas ac nec quam. Phasellus volutpat libero commodo consectetur scelerisque. Pellentesque efficitur eu libero sit amet rutrum. Aenean magna mauris, blandit a imperdiet vel, pellentesque ac sem.";

  let page = {
    1: {
      title: "Welcome",
      image: "https://react.semantic-ui.com/images/avatar/large/rachel.png",
      content: (
        <Container>
          <p>{placeholderText}</p>
        </Container>
      ),
      controls: <Button onClick={props.nextPage}>Next</Button>
    },
    2: {
      title: "About",
      image: "https://react.semantic-ui.com/images/avatar/large/rachel.png",
      content: (
        <Container>
          <p>{placeholderText}</p>
        </Container>
      ),
      controls: <Button onClick={props.nextPage}>Next</Button>
    },
    3: {
      title: "Save Your Progress",
      image: "https://react.semantic-ui.com/images/avatar/large/rachel.png",
      content: (
        <Container>
          <p>{placeholderText}</p>
          <Container textAlign="center" />
        </Container>
      ),
      controls: (
        <div>
          <Button>Register</Button>
          <Button onClick={props.nextPage}>Skip For Now</Button>
        </div>
      )
    },
    4: {
      title: "Start Your Path",
      image: "https://react.semantic-ui.com/images/avatar/large/rachel.png",
      content: (
        <Container>
          <p>{placeholderText}</p>
          <Container textAlign="center" />
        </Container>
      ),
      controls: (
        <Button icon labelPosition="right" onClick={props.handleClose}>
          Start First Learning Path
          <Icon name="right arrow" />
        </Button>
      )
    }
  };

  if (!page[props.page]) {
    return <div />;
  }

  return (
    <Modal.Content image>
      <Image wrapped src={page[props.page].image} />
      <Modal.Description>
        <Header as="h1">{page[props.page].title}</Header>
        {page[props.page].content}
        <Container textAlign="center" style={{ marginTop: "50px" }}>
          {page[props.page].controls}
        </Container>
      </Modal.Description>
    </Modal.Content>
  );
};

export default LearningPathAboutPage;
