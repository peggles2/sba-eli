import React from "react";
import { BrowserRouter as Router } from "react-router-dom";
import { Dropdown } from "semantic-ui-react";
import { NavigationLearningPath } from "../NavigationLearningPath";
import { shallow, mount } from "enzyme";

describe("NavigationLearningPath", () => {
  it("should render correctly", () => {
    const wrapper = shallow(<NavigationLearningPath />);

    expect(wrapper).toMatchSnapshot();
  });

  it("should render a <Dropdown>", () => {
    const wrapper = mount(
      <Router>
        <NavigationLearningPath />
      </Router>
    );

    const learningpaths = [
      { id: 1, name: "Learning Path 1" },
      { id: 2, name: "Learning Path 2" },
      { id: 3, name: "Learning Path 3" }
    ];

    wrapper
      .find(NavigationLearningPath)
      .setState({ learningPaths: learningpaths });

    expect(wrapper.find(Dropdown.Item).length).toEqual(6);
  });
});
